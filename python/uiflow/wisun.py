"""
Module to control Rohm BP35A1
License: Boost Software License 1.0
"""

import logging
import time
import _thread
import struct
import gc

try:
    from mpy_builtins import machine, const
    from typing import Tuple, Callable, List, Dict, Optional, Union, Any
except:
    import machine

class CancelledError(BaseException):
    def __init__(self):
        pass

cancelled_error = CancelledError()
stop_iteration = StopIteration()

class SleepAwaitable(object):
    def __init__(self):
        self.value = None # type:Optional[Union[float, BaseException]]
        
    def __call__(self, value: Optional[Union[float, BaseException]]):
        self.value = value
        return self
    
    def __iter__(self):
        return self
    
    def __next__(self):
        if self.value is None:
            raise stop_iteration
        elif self.value is BaseException:
            raise self.value
        else:
            time.sleep(self.value)
            self.value = None
            return self

class asyncio(object):
    _sleep_awaitable = SleepAwaitable()

    @staticmethod
    def sleep_ms(duration_ms:int) -> SleepAwaitable:
        return asyncio._sleep_awaitable(duration_ms*1.0e-3)
    @staticmethod
    def sleep(duration:float) -> SleepAwaitable:
        return asyncio._sleep_awaitable(duration)

class BP35A1Error(RuntimeError):
    def __init__(self, message:str) -> None:
        super().__init__(message)

class WaitEvent(object):
    def __init__(self):
        self.__lock = _thread.allocate_lock()
        self.__value_lock = _thread.allocate_lock()
        self.__value = None
        self.__lock.acquire()

    def notify(self, value: Any):
        self.__value_lock.acquire()
        self.__value = value
        self.__value_lock.release()
        self.__lock.acquire(False)
        self.__lock.release()
    
    def wait(self, timeout: float = -1) -> Optional[Any]:
        while True:
            self.__value_lock.acquire()
            if self.__value is not None:
                value = self.__value
                self.__value = None
                self.__value_lock.release()
                return value
            else:
                self.__value_lock.release()
            if not self.__lock.acquire(True, timeout):
                return None

    def release(self):
        self.__lock = None
    
class IOExpander(object):
    "I/O Expander on I2C bus"

    REG_INPUT     = const(0)
    REG_OUTPUT    = const(1)
    REG_INVERSION = const(2)
    REG_CONFIG    = const(3)

    def __init__(self, i2c: machine.I2C, address: int, output:int=0x00, inversion:int=0xf0, direction:int=0xff):
        """
        Initialize I/O expander driver
        i2c: machine.I2C object on which the I/O expander is.
        address: I2C slave address of the I/O expander.
        """
        self.__i2c = i2c
        self.__address = address
        self.__regs = memoryview(bytearray([0x00, output, inversion, direction]))
        self.__apply()

    def __apply(self) -> None:
        for i in range(1, 4):
            self.__i2c.writeto_mem(self.__address, i, self.__regs[i:i+1])
        
    def configure(self, direction:int, inversion:int, output:int) -> None:
        self.__regs[IOExpander.REG_OUTPUT]    = output
        self.__regs[IOExpander.REG_INVERSION] = inversion
        self.__regs[IOExpander.REG_CONFIG]    = direction
        self.__apply()
    
    def input(self) -> int:
        self.__i2c.readfrom_into(self.__address, IOExpander.REG_INPUT, self.__regs[IOExpander.REG_INPUT:IOExpander.REG_INPUT+1])
        return self.__regs[IOExpander.REG_INPUT]
    
    def last_input(self) -> int:
        return self.__regs[IOExpander.REG_INPUT]
    
    def output(self, value:Optional[int,None]=None, mask:int=0xff) -> int:
        if value is not None:
            self.__set_masked(IOExpander.REG_OUTPUT, value, mask)
        return self.__regs[IOExpander.REG_OUTPUT]
    
    def direction(self, value:Optional[int,None]=None, mask:int=0xff) -> int:
        if value is not None:
            self.__set_masked(IOExpander.REG_CONFIG, value, mask)
        return self.__regs[IOExpander.REG_CONFIG]
    
    def __set_masked(self, reg:int, value:int, mask:int) -> None:
        self.__regs[reg] = (self.__regs[reg] & ~mask) | value
        self.__i2c.writeto_mem(self.__address, reg, self.__regs[reg:reg+1])
    
    def pin(self, pin:int) -> IOExpanderPin:
        return IOExpanderPin(self, pin)

class IOExpanderPin(object):
    def __init__(self, ioe:IOExpander, pin:int):
        self.__ioe  = ioe
        self.__mask = 1<<pin

    def value(self, x:Optional[bool,None]=None) -> bool:
        if x is not None:
            value = self.__mask if x else 0
            self.__ioe.output(value=value, mask=self.__mask)
        if (self.__ioe.direction() & self.__mask) == 0:
            return (self.__ioe.output() & self.__mask) != 0
        else:
            return (self.__ioe.input() & self.__mask) != 0
    
    def on(self) -> None:
        self.value(True)

    def off(self) -> None:
        self.value(False)
    
class BP35A1(object):
    "Controls Rohm BP35A1 Wi-SUN ECHONET module"
    CR = const(0x0d)
    LF = const(0x0a)
    SPC = const(0x20)

    IOEXPANDER_REG_OUTPUT = 0x02
    IOEXPANDER_OUTPUT_WKUP   = 0x01
    IOEXPANDER_OUTPUT_RESET  = 0x02
    IOEXPANDER_OUTPUT_RTS    = 0x04

    def __init__(self, uart: machine.UART, wkup: Optional[machine.Pin], reset: machine.Pin) -> None:
        "Construct BP35A1 instance"
        self.__l = logging.Logger('BP35A1')
        self.__uart = uart
        self.__wkup = wkup
        self.__reset = reset
        self.__buffer = bytearray(1024)
    
    def initialize(self) -> None:
        "Initialize I/O ports and peripherals to communicate with the module."
        if self.__wkup is not None:
            self.__wkup.value(True)
        self.__reset.value(False) # Assert RESET
        self.__uart.init(baudrate=115200, timeout=5000)
        
    async def reset(self) -> bool:
        "Reset the module."
        
        self.__reset.value(False) # Assert RESET at least 1 [ms]
        await asyncio.sleep_ms(10) # /
        self.__reset.value(True)  # Deassert RESET
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
        mv = memoryview(self.__buffer)
        while True:
            response_length = await self.read_response_into(self.__buffer, timeout=timeout)
            if response_length is None:
                # timed out
                return False
            else:
                self.__l.debug("response: %s", self.__buffer[:response_length])
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

    async def read_response_block(self, buffer:bytearray, offset:int=0, timeout:Optional[int] = None) -> Optional[int]:
        buffer_length = len(buffer)
        response_length = 0
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
            # self.__l.debug('%c', c)
            if c == BP35A1.CR or c == BP35A1.LF:
                pass
            elif c == BP35A1.SPC:
                return response_length
            else:
                buffer[offset+response_length] = c
                response_length += 1
                if offset+response_length == buffer_length:
                    return response_length
            
    
    async def receive(self, buffer:bytearray, timeout:Optional[int] = None) -> Optional[memoryview]:
        head = b'ERXUDP'
        head_len = len(head)
        mv = memoryview(buffer)
        start_time_ms = time.ticks_ms()
        while timeout is None or time.ticks_ms() - start_time_ms < timeout:
            response = await self.read_response_block(mv, timeout=timeout)
            if response is None or response != head_len or mv[:head_len] != head:
                pass
            else:
                # self.__l.debug('response:{0}'.format(bytes(mv[:response])))
                break
        block_count = 1
        while True:
            response = await self.read_response_block(mv, timeout=timeout)
            if response is None:
                return None
            self.__l.debug('response block{0}:{1}'.format(block_count, bytes(mv[:response])))
            block_count += 1
            if block_count == 8:
                data_len = int(str(mv[:response], 'utf-8'), 16)
                break

        self.__l.debug('ERXUDP DATALEN={0}'.format(data_len))
        bytes_read = self.__uart.readinto(mv[:data_len])
        return mv[:bytes_read+1]


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
        response = memoryview(self.__buffer) if len(self.__buffer) <= max_response_size else bytearray(max_response_size)
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
        result, responses = await self.execute_command(command, self.__buffer, timeout=timeout)
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
        


class EchonetLiteFrame(object):
    ESV_SETI_SNA   = 0x50
    ESV_SETC_SNA   = 0x51
    ESV_GET_SNA    = 0x52
    ESV_INF_SNA    = 0x53
    ESV_SETGET_SNA = 0x5e    
    ESV_SETI       = 0x60
    ESV_SETC       = 0x61
    ESV_GET        = 0x62
    ESV_INF_REQ    = 0x63
    ESV_SETGET     = 0x6e
    ESV_SET_RES    = 0x71
    ESV_GET_RES    = 0x72
    ESV_INF        = 0x73
    ESV_INFC       = 0x74
    ESV_INFC_RES   = 0x7a
    ESV_SETGET_RES = 0x7e

    def __init__(self, buffer):
        if not isinstance(buffer, memoryview):
            self._m = memoryview(buffer)
        else:
            self._m = buffer # type: memoryview
        self._next_offset = 12
    
    def is_valid(self) -> bool:
        if self._m is None or len(self._m) < 4:
            return False
        # Check EHD
        if not (self._m[0] == 0x10 and self._m[1] == 0x81):
            return False
        return True
    
    def init(self) -> None:
        self._m[0] = 0x10
        self._m[1] = 0x81

    def tid(self, value:Optional[int]=None)->int:
        if value is not None:
            self._m[2] = value >> 8
            self._m[3] = value & 0xff
        return (self._m[2] << 8) | self._m[3]
    def seoj(self, value:Optional[bytes]=None)->memoryview:
        if value is not None:
            self._m[4:4+3] = value
        return self._m[4:4+3]
    def deoj(self, value:Optional[bytes]=None)->memoryview:
        if value is not None:
            self._m[7:7+3] = value
        return self._m[7:7+3]
    def esv(self, value:Optional[int]=None)->int:
        if value is not None:
            self._m[10] = value
        return self._m[10]
    def opc(self, value:Optional[int]=None)->int:
        if value is not None:
            self._m[11] = value
        return self._m[11]
    
    def target_properies(self)->Generator[memoryview, None, None]:
        opc = self.opc()
        offset = 12
        for i in range(opc):
            if offset + 1 >= len(self._m):
                break
            pdc = self._m[offset + 1]
            if offset + 2 + pdc >= len(self._m):
                break
            yield self._m[offset:offset + 2 + pdc]
            offset += 2 + pdc
    
    def clear_properties(self)->None:
        self.opc(0)
        self._next_offset = 12
    
    def add_property(self, epc:int, data:Optional[bytes])->None:
        self._m[self._next_offset + 0] = epc
        data_len = len(data) if data is not None else 0
        self._m[self._next_offset + 1] = data_len
        if data_len > 0:
            self._m[self._next_offset + 2:self._next_offset + 2 + data_len] = data
        self._next_offset += 2 + data_len
        self.opc(self.opc() + 1)

    def get_length(self) -> int: 
        return self._next_offset
    
    def bytes(self)->memoryview:
        return self._m[:self._next_offset+1]

PROPERTY_COEFFICIENT      = const(0xd3) # 係数
PROPERTY_CUMULATIVE_VALUE = const(0xe0) # 積算電力量計測値
PROPERTY_CUMULATIVE_UNIT  = const(0xe1) # 積算電力量単位
PROPERTY_INSTANT_POWER    = const(0xe7) # 瞬時電力計測値
PROPERTY_INSTANT_CURRENT  = const(0xe8) # 瞬時電流計測値

# Construct ECHONETlite request frame
getPropertyFrame = EchonetLiteFrame(bytearray(64))
getPropertyFrame.init()
getPropertyFrame.tid(0x0000)            # TID = 0x0000
getPropertyFrame.seoj(b'\x05\xff\x01')  # SEOJ 送信元EOJ クラスグループ=管理・操作関連機器, クラス=コントローラ
getPropertyFrame.deoj(b'\x02\x88\x01')  # DEOJ 送信先EOJ クラスグループ=住宅・設備関連機器, クラス=低圧スマート電力量メータ
getPropertyFrame.esv(EchonetLiteFrame.ESV_GET)  # プロパティ読み出し要求
getPropertyFrame.add_property(PROPERTY_COEFFICIENT     , None)   
getPropertyFrame.add_property(PROPERTY_CUMULATIVE_VALUE, None)   
getPropertyFrame.add_property(PROPERTY_CUMULATIVE_UNIT , None)   
getPropertyFrame.add_property(PROPERTY_INSTANT_POWER   , None)   
getPropertyFrame.add_property(PROPERTY_INSTANT_CURRENT , None) 


class WiSUN(object):
    STATE_ERROR        = const(-1)
    STATE_INITIALIZING = const(0)
    STATE_SCANNING     = const(1)
    STATE_CONNECTING   = const(2)
    STATE_CONNECTED    = const(3)
    
    @staticmethod
    def __thread_proc(obj: WiSUN) -> None:
        runner = obj.__run() # type: SleepAwaitable
        try:
            while True:
                next(runner)
                runner.send(None)
        except StopIteration:
            pass
        print('WiSUN thread stopped')

    def __init__(self, uart: machine.UART, wake_up: Optional[machine.Pin], reset: machine.Pin):
        self.__lock = _thread.allocate_lock()
        self.__thread = None
        self.__bp35 = BP35A1(uart, wake_up, reset)
        self.__state = WiSUN.STATE_INITIALIZING
        self.__l = logging.Logger('WiSUN')
        self.__route_b_id       = None # type: Optional[str]
        self.__route_b_password = None # type: Optional[str]
        self.__instant_power = None # type: Optional[float]
        self.__cumulative_power = None # type: Optional[float]
        self.__timestamp = None # type: Optional[float]
        self.__wait = WaitEvent()
        self.__update_interval = 30

    def start(self, route_b_id: str, route_b_password: str, update_interval: int = 30) -> None:
        self.__route_b_id = route_b_id
        self.__route_b_password = route_b_password
        self.__update_interval = update_interval
        self.__thread = _thread.start_new_thread(WiSUN.__thread_proc, (self,))

    def __make_values(self) -> Dict[str, Any]:
        return {
            'instant_power': self.__instant_power,
            'cumulative_power': self.__cumulative_power,
            'timestamp': self.__timestamp,
            'state': self.__state,
        }
    def __notify_values(self) -> None:
        values = self.__make_values()
        self.__wait.notify(values)
    
    def state(self) -> int:
        self.__lock.acquire()
        value = self.__state
        self.__lock.release()
        return value
    
    def __set_state(self, state: int) -> None:
        self.__lock.acquire()
        self.__state = state
        self.__notify_values()
        self.__lock.release()
    
    def values(self) -> Dict[str, Any]:
        self.__lock.acquire()
        values = self.__make_values()
        self.__lock.release()
        return values
    
    def wait_values(self, timeout: float = -1) -> Optional[Dict[str, Any]]:
        return self.__wait.wait()

    async def __run(self):
        response_buffer = bytearray(1024)

        while True:
            self.__set_state(WiSUN.STATE_INITIALIZING)
            if not await self.__bp35.reset():
                self.__l.error('Failed to reset the Wi-SUN module.')
                self.__set_state(WiSUN.STATE_ERROR)
                await asyncio.sleep(1)
                continue
            if not await self.__bp35.set_password(self.__route_b_password, timeout=5000):
                self.__l.error('Failed to set password.')
                continue
            if not await self.__bp35.set_route_b_id(self.__route_b_id, timeout=5000):
                self.__l.error('Failed to set route-b ID.')
                continue
                
            while True:
                self.__set_state(WiSUN.STATE_SCANNING)
                self.__l.info("Scanning PANs...")
                success, pans = await self.__bp35.scan(0xffffffff, 6, timeout=1000, scan_timeout=30000)
                if success:
                    self.__l.info("PANs detected: {0}".format(pans))
                    break
                else:
                    self.__l.error("Failed to scan PANs")
            
            if len(pans) == 0:
                continue
        
            ## Connecting
            self.__set_state(WiSUN.STATE_CONNECTING)
            gc.collect()
            pan = pans[0] # type: Dict[bytes, bytes]
            if not (b'Channel' in pan and b'Pan ID' in pan and b'Addr' in pan):
                self.__l.error("Invalid PAN information")
                continue

            channel     = int(str(pan[b'Channel'], 'utf-8'), 16)
            pan_id      = str(pan[b'Pan ID'], 'utf-8')
            mac_address = str(pan[b'Addr'], 'utf-8')
            
            if not await self.__bp35.set_channel(channel, timeout=1000):
                self.__l.error("Failed to set channel.")
                continue
            if not await self.__bp35.set_pan_id(pan_id, timeout=1000):
                self.__l.error("Failed to set PAN ID")
                continue
            ll_address = await self.__bp35.get_link_local_address(mac_address, timeout=1000)
            if ll_address is None:
                self.__l.error("Failed to get link local address")
                continue
            
            if not await self.__bp35.connect_to(ll_address, timeout=10000):
                self.__l.error("Failed to connect to the coordinator.")
                continue
            
            self.__set_state(WiSUN.STATE_CONNECTED)
            no_response_count = 0
            no_response_reset_count = 0
            while True:
                gc.collect()
                if await self.__bp35.send_to(True, ll_address, 0xe1a, getPropertyFrame.bytes(), timeout=10000):
                    response = await self.__bp35.receive(response_buffer, timeout=10000)
                    if response is None:
                        no_response_count += 1
                        if no_response_count >= 6: # Reset if there are no responses more than 6 times.
                            self.__l.info("No response. Perform reset.")
                            no_response_reset_count += 1
                            break
                    else:
                        no_response_count = 0
                        frame = EchonetLiteFrame(response)
                        if frame.is_valid():
                            seoj = frame.seoj()
                            esv  = frame.esv()
                            
                            instant_power = None # type: Optional[float]
                            instant_current = None # type: Optional[Tuple[float,float]]
                            coefficient = 1
                            cumulative_unit = 1.0
                            cumulative_value = None

                            self.__l.debug("seoj={0}, esv={1}".format(seoj, esv))
                            if seoj == b'\x02\x88\x01' and esv == EchonetLiteFrame.ESV_GET_RES: # Is the response for the request to read property?
                                for mv in frame.target_properies():
                                    if mv[0] == PROPERTY_INSTANT_POWER and mv[1] == 4 and len(mv) == 6:   # instant power
                                        power = struct.unpack('>i', mv[2:])[0]
                                        self.__l.info('Power={0}[W]'.format(power))
                                        instant_power = power
                                    elif mv[0] == PROPERTY_INSTANT_CURRENT and mv[1] == 4 and len(mv) == 6:   # instant current
                                        current_r, current_t = struct.unpack('>hh', mv[2:])
                                        self.__l.info('Current R={0},T={1}[dA]'.format(current_r, current_t))
                                        instant_current = (current_r, current_t)
                                    elif mv[0] == PROPERTY_COEFFICIENT and mv[1] == 4 and len(mv) == 6: # coefficient
                                        coefficient = struct.unpack('>I', mv[2:])[0]
                                        self.__l.debug('Coefficient={0}'.format(coefficient))
                                    elif mv[0] == PROPERTY_CUMULATIVE_UNIT and mv[1] == 1 and len(mv) == 3: # unit
                                        unit = mv[2]
                                        if unit == 0x00:
                                            cumulative_unit = 1.0e0
                                        elif unit == 0x01:
                                            cumulative_unit = 1.0e-1
                                        elif unit == 0x02:
                                            cumulative_unit = 1.0e-2
                                        elif unit == 0x03:
                                            cumulative_unit = 1.0e-3
                                        elif unit == 0x04:
                                            cumulative_unit = 1.0e-4
                                        elif unit == 0x0a:
                                            cumulative_unit = 1.0e+1
                                        elif unit == 0x0b:
                                            cumulative_unit = 1.0e+2
                                        elif unit == 0x0c:
                                            cumulative_unit = 1.0e+3
                                        elif unit == 0x0d:
                                            cumulative_unit = 1.0e+4
                                        self.__l.debug('CumulativeUnit={0}'.format(cumulative_unit))
                                    elif mv[0] == PROPERTY_CUMULATIVE_VALUE and mv[1] == 4 and len(mv) == 6: # cumulative power
                                        cumulative_value = struct.unpack('>I', mv[2:])[0]
                                        self.__l.debug('CumulativeValue={0}'.format(cumulative_value))
                                
                                updated = False
                                self.__lock.acquire()
                                if instant_power is not None:
                                    self.__instant_power = instant_power
                                    updated = True
                                if instant_current is not None:
                                    self.__instant_current = instant_current
                                    updated = True
                                if cumulative_value is not None:
                                    self.__cumulative_power = cumulative_value*cumulative_unit
                                    updated = True
                                self.__lock.release()
                                
                                if updated:
                                    self.__timestamp = time.time()
                                    self.__notify_values()
                                
                                await asyncio.sleep(self.__update_interval)
                    
