import logging
import time
import uasyncio as asyncio

try:
    from mpy_builtins import machine, const
    from typing import Tuple, Callable, List, Dict, Optional, Union
except:
    import machine


class BP35A1Error(RuntimeError):
    def __init__(self, message:str) -> None:
        super().__init__(message)

class BP35A1(object):
    "Controls Rohm BP35A1 Wi-SUN ECHONET module"
    CR = const(0x0d)
    LF = const(0x0a)

    IOEXPANDER_REG_OUTPUT = 0x02
    IOEXPANDER_OUTPUT_WKUP   = 0x01
    IOEXPANDER_OUTPUT_RESET  = 0x02
    IOEXPANDER_OUTPUT_RTS    = 0x04

    def __init__(self, uart: machine.UART, i2c: machine.I2C, i2c_addr: int = 0x64) -> None:
        self.__l = logging.Logger('BP35A1')
        self.__i2c = i2c
        self.__uart = uart
        self.__i2c_addr = i2c_addr
        self.__ioe_out = bytearray(b'\x00')
        self.__sr = asyncio.StreamReader(self.__uart)
    
    def __set_ioe_bit(self, bit:int, to_set:bool) -> None:
        if to_set:
            self.__ioe_out[0] = self.__ioe_out[0] | bit
        else:
            self.__ioe_out[0] = self.__ioe_out[0] & (~bit)
        self.__update_ioe_output()

    def __update_ioe_output(self) -> None:
        self.__i2c.writeto_mem(self.__i2c_addr, BP35A1.IOEXPANDER_REG_OUTPUT, self.__ioe_out)

    def initialize(self) -> None:
        "Initialize I/O ports and peripherals to communicate with the module."
        self.__l.debug('initialize')
        self.__ioe_out[0] = BP35A1.IOEXPANDER_OUTPUT_WKUP | BP35A1.IOEXPANDER_OUTPUT_RTS  # Assert RESET
        self.__update_ioe_output()
        self.__uart.init(baudrate=115200, timeout=5000)
        
    async def reset(self) -> bool:
        "Reset the module."
        
        self.__set_ioe_bit(BP35A1.IOEXPANDER_OUTPUT_RESET, False)  # Assert RESET
        self.__set_ioe_bit(BP35A1.IOEXPANDER_OUTPUT_RESET, True)  # Deassert RESET
        await asyncio.sleep_ms(3000)    # We must wait 3000 milliseconds after RESET pin is deasserted. (HW spec p.14)

        responded = False
        for trial in range(15):
            self.write_command(b'SKVER')
            if await self.wait_response(b'SKVER', timeout=500) is not None:
                if await self.wait_response(b'EVER', timeout=500) is not None:
                    if await self.wait_response(b'OK', timeout=500) is not None:
                        responded = True
                        break
        if not responded:
            self.__l.info("The module did not respond within timeout period.")
            return False
        
        # Disable command echo-back
        if not await self.write_command_wait(b'SKSREG SFE 0', b'OK', timeout=1000):
            self.__l.error("Failed to initialize the module.")
        
        return True
        
    async def set_password(self, password: str, timeout:int = None) -> bool:
        "Generate PSK from the password and register it."
        length = len(password)
        if length == 0 or length > 32:
            raise ValueError('The password length must be from 1 to 32 inclusive.')
        command = bytes('SKSETPWD {0:02X} {1}'.format(length, password), 'utf-8')
        return await self.write_command_wait(command, b'OK', timeout=timeout)

    async def set_route_b_id(self, route_b_id: str, timeout:Optional[int] = None) -> bool:
        "Sets Route-B ID"
        length = len(route_b_id)
        if length != 32:
            raise ValueError('The Route-B ID length must be 32.')
        command = bytes('SKSETRBID ' + route_b_id, 'utf-8')
        return await self.write_command_wait(command, b'OK', timeout=timeout)

    async def scan(self, channel_mask:int, scan_duration:int, timeout:Optional[int] = None, scan_timeout:Optional[int] = None) -> Tuple[bool, List[Dict[bytes, bytes]]]:
        "Perform active scan and collect PAN list."
        if scan_duration < 0 or scan_duration > 14:
            raise ValueError('scan_duration must be from 0 to 14 inclusive.')
        command = bytes('SKSCAN 2 {0:8X} {1}'.format(channel_mask, scan_duration), 'utf-8')
        if not await self.write_command_wait(command, b'OK', timeout=timeout):
            return False, []
        
        buffer = bytearray(1024)
        mv = memoryview(buffer)
        pans = [] # type: List[Dict[bytes, bytes]]
        pan = None # type: Optional[Dict[bytes, bytes]]
        while True:
            response_length = await self.read_response_into(buffer, timeout=scan_timeout)
            if response_length is None:
                # Timed out.
                return False, pans
            
            response = mv[:response_length] # type: memoryview
            self.__l.debug("response: %s", bytes(response))
            if response == b'EPANDESC':
                if pan is not None:
                    pans.append(pan)
                pan = {}
            elif response_length >= 8 and response[:8] == b'EVENT 22':   # end of scan
                if pan is not None: # Add the last PAN
                    pans.append(pan)
                break
            elif response_length >= 6 and response[:6] == b'EVENT ': # Other event
                pass    # Just ignore this response.
            else:
                if pan is not None:
                    pair = bytes(response) # type: bytes
                    key, value = pair.strip().split(b':', 2)
                    if value is None:
                        pan[b'PairID'] = key
                    else:
                        pan[key] = value

            
        return True, pans
    
    async def set_channel(self, channel: int, timeout:Optional[int] = None) -> bool:
        "Sets communication channel"
        command = bytes('SKSREG S2 {0:02X}'.format(channel), 'utf-8')
        return await self.write_command_wait(command, b'OK', timeout=timeout)
    
    async def set_pan_id(self, pan_id: str, timeout:Optional[int] = None) -> bool:
        "Sets PAN ID"
        command = b'SKSREG S3 ' + bytes(pan_id, 'utf-8')
        return await self.write_command_wait(command, b'OK', timeout=timeout)
    
    async def get_link_local_address(self, mac_address:str, timeout:Optional[int] = None) -> Optional[str]:
        "Gets the link local address from the corresponding MAC address."
        command = b'SKLL64 ' + bytes(mac_address, 'utf-8')
        self.write_command(command)
        buffer = bytearray(1024)
        response_length = await self.read_response_into(buffer, timeout=timeout)
        if response_length is None:
            return None
        else:
            return str(buffer[:response_length], 'utf-8')

    async def connect_to(self, ll_address:str, timeout:Optional[int] = None) -> bool:
        "Connect to a PAA as a PaC"
        command = b'SKJOIN ' + bytes(ll_address, 'utf-8')
        if not await self.write_command_wait(command, b'OK', timeout=timeout):
            return False
        
        # Wait until EVENT 0x25 (PANA connection has completed successfully) arrives.
        buffer = bytearray(1024)
        mv = memoryview(buffer)
        while True:
            response_length = await self.read_response_into(buffer, timeout=timeout)
            if response_length is None:
                # timed out
                return False
            else:
                self.__l.debug("response: %s", buffer[:response_length])
                if response_length > 8:
                    if mv[:8] == b'EVENT 24':
                        # PANA connection failed.
                        return False
                    elif mv[:8] == b'EVENT 25':
                        # PANA connection complete
                        return True

    async def send_to(self, do_encrypt:bool, ll_address:str, port:int, data:bytes, timeout:Optional[int] = None) -> bool:
        encrypt_flag = '1' if do_encrypt else '0'
        command = bytes('SKSENDTO 1 {0} {1:04X} {2} {3:04X} '.format(ll_address, port, encrypt_flag, len(data)), 'utf-8')
        self.write(command)
        self.write(data)
        return await self.wait_response(b'OK', timeout=timeout) is not None

    async def receive(self, buffer:bytearray, timeout:Optional[int] = None) -> Optional[memoryview]:
        while True:
            response = await self.wait_response_into(b'ERXUDP ', buffer, timeout=timeout)
            if response is None:
                return None
            
            blocks = [] # type: List[memoryview]
            start = 0
            index = 0
            while True:
                if index >= len(response):
                    break
                if response[index] == 0x20: # space
                    blocks.append(memoryview(response[start:index]))
                    start = index + 1
                    if len(blocks) == 8:
                        break
                index += 1
            self.__l.debug('blocks: {0}'.format(blocks))
            if len(blocks) < 8:
                return None
            data_len = int(str(bytes(blocks[7]), 'utf-8'), 16)
            self.__l.debug(bytes(response))
            self.__l.debug('ERXUDP DATALEN={0}'.format(data_len))
            data = response[start:]
            return data


    def write(self, s:bytes) -> None:
        self.__l.debug('<- %s', s)
        self.__uart.write(s)
    
    def read(self, length:int) -> bytes:
        return self.__uart.read(length)
    
    def write_command(self, command:bytes) -> None:
        self.__l.debug('<- %s', command)
        self.__uart.write(command)
        self.__uart.write(b'\r\n')

    async def write_command_wait(self, command:bytes, expected_response:bytes, timeout:Optional[int] = None) -> bool:
        self.write_command(command)
        return await self.wait_response(expected_response, timeout=timeout) is not None


    def __readchar(self) -> int:
        char_buffer = bytearray(1)
        n = self.__uart.readinto(char_buffer)
        return -1 if n is None or n == 0 else char_buffer[0]
    
    async def read_response_into(self, buffer:bytearray, offset:int=0, timeout:Optional[int] = None) -> Optional[int]:
        buffer_length = len(buffer)
        response_length = 0
        state = 0
        start_time_ms = time.ticks_ms()
        while True:
            c = self.__readchar()
            if c < 0:
                if timeout is not None and (time.ticks_ms()-start_time_ms) >= timeout:
                    return None
                try:
                    await asyncio.sleep_ms(1)
                except asyncio.CancelledError:
                    return None
                continue
            
            #self.__l.debug('S:%d R:%c', state, c)
            if state == 0 and c == BP35A1.CR:
                state = 0 if response_length == 0 else 1
            elif state == 0 and c == BP35A1.LF:
                state = 0
            elif state == 0:
                buffer[offset+response_length] = c
                response_length += 1
                if offset+response_length == buffer_length:
                    return response_length
            elif state == 1 and c == BP35A1.LF:
                return response_length
            elif state == 1 and c == BP35A1.CR:
                state = 1
            elif state == 1:
                state = 0
    
    async def wait_response(self, expected_response:bytes, max_response_size:int=1024, timeout:Optional[int] = None) -> Optional[bytes]:
        self.__l.debug('wait_response: target=%s', expected_response)
        response = bytearray(max_response_size)
        expected_length = len(expected_response)
        while True:
            length = await self.read_response_into(response, timeout=timeout)
            if length is None: return None
            self.__l.debug("wait_response: response=%s", response[:length])
            if length >= expected_length and response[:expected_length] == expected_response:
                return response[:length]
    
    async def wait_response_into(self, expected_response:bytes, response_buffer:bytearray, timeout:Optional[int] = None) -> Optional[memoryview]:
        self.__l.debug('wait_response_into: target=%s', expected_response)
        expected_length = len(expected_response)
        mv = memoryview(response_buffer)
        while True:
            length = await self.read_response_into(response_buffer, timeout=timeout)
            if length is None: return None
            self.__l.debug("wait_response_into: response=%s", bytes(mv[:length]))
            if length >= expected_length and mv[:expected_length] == expected_response:
                return mv[:length]

    async def wait_prompt(self, expected_prompt:bytes, timeout:Optional[int] = None) -> bool:
        prompt_length = len(expected_prompt)
        index = 0
        start_time_ms = time.ticks_ms()
    
        while True:
            c = self.__readchar()
            if c < 0:
                if time.ticks_ms() - start_time_ms > timeout:
                    return False
                await asyncio.sleep_ms(1)
                continue
            if expected_prompt[index] == c:
                index += 1
                if index == prompt_length:
                    return True
            else:
                index = 0
        
    async def execute_command(self, command:bytes, response_buffer:bytearray, index:int=0, expected_response_predicate:Callable[[memoryview],bool]=None, expected_response_list:List[bytes]=[b'OK'], timeout:int=None) -> Tuple[bool, List[memoryview]]:
        assert expected_response_predicate is not None or expected_response_list is not None
        if expected_response_predicate is None:
            expected_response_predicate = lambda mv: mv in expected_response_list 
        self.write_command(command)
        buffer_length = len(response_buffer)
        responses = [] # type: List[memoryview]
        mv = memoryview(response_buffer)
        while True:
            length = await self.read_response_into(response_buffer, index, timeout=timeout)
            if length is None:
                return (False, responses)
            response = mv[index:index+length]
            responses.append(response)
            if expected_response_predicate(response):
                return (True, responses)
            index += length

    async def execute_command_single_response(self, command:bytes, starts_with:bytes=None, timeout:Optional[int] = None) -> Optional[bytes]:
        buffer = bytearray(1024)
        result, responses = await self.execute_command(command, buffer, timeout=timeout)
        if not result: return None
        starts_with_length = len(starts_with) if starts_with is not None else 0

        for response in responses: # type: Union[memoryview, bytes]
            if starts_with_length == 0 and len(response) > 0:
                response = bytes(response)
                self.__l.debug('-> %s', response)
                return response
            if starts_with_length > 0 and len(response) >= starts_with_length and response[:starts_with_length] == starts_with:
                response = bytes(response)
                self.__l.debug('-> %s', response)
                return response
        return None
        

