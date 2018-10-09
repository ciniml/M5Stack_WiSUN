try:
    from mpy_builtins import machine, const
    from typing import Tuple, Callable, List, Dict, Optional, Union, Generator, Optional
except:
    from m5stack import lcd
    import machine
    import network
    import time
    from machine import reset

import gc
import logging
import uasyncio as asyncio
from bp35 import BP35A1
import struct
import appconfig

def reset(): 
    machine.reset()

# Configure logger.
#logging.basicConfig(logging.DEBUG)
log = logging.Logger('MAIN')

# Start Wi-Fi
w = network.WLAN()
w.active(True)
w.connect(appconfig.wifi_ssid, appconfig.wifi_password)
time.sleep(5)

# Start FTP server to upload source codes.
network.ftp.start(user='esp32', password='esp32')

#
i2c = machine.I2C(id=1, sda=21, scl=22, mode=machine.I2C.MASTER, speed=100000)

log.info('Scanning I2C bus...')
i2c_devices = i2c.scan() # type: List[int]

log.info('Detected devices are: {0}'.format(str(i2c_devices)))

# Load IO Expander binary 
bl_addr = const(0x65)
if bl_addr in i2c_devices:
    log.info('The IO expander is in bootloader mode.')
    # Bootloader exists on the bus.
    # First, we have to check whether the target application is already loaded or not.
    with open('/flash/ioexpander.bin', 'rb') as f:
        page_size = const(128)
        b = f.read()
        progmem = i2c.readfrom_mem(bl_addr, 0x0000, len(b), adrlen=2)

        # The contents in the program memory of IO expander differs from the target firmware.
        if b != progmem:
            log.info('The IO expander firmware must be downloaded.')
            i2c.writeto_mem(bl_addr, 0x8003, b'\xac', adrlen=2)
            l = len(b)
            if (l & (page_size - 1)) != 0:
                l = (l + page_size - 1) & ~(page_size - 1)
                padding = l - len(b)
                b += b'\x00'*padding
            mv = memoryview(b)   
            for base in range(0, l, page_size):
                i2c.writeto_mem(bl_addr, base, mv[base:base+page_size], adrlen=2)
                time.sleep_ms(100)

    log.info('Boot the IO expander')
    # Boot IO Expander
    i2c.writeto_mem(bl_addr, 0x8001, b'\x01', adrlen=2)
    time.sleep_ms(250)


gc.collect()

# Rescan I2C bus...
bp35_addr = const(0x64)
i2c_devices = i2c.scan()
log.info('Detected devices are: {0}'.format(str(i2c_devices)))

if bp35_addr not in i2c_devices:
    log.error('IO expander device was not found.')
    machine.deepsleep()

time.sleep(1)
bp35_uart = machine.UART(1, rx=5, tx=2, baudrate=115200, lineend='\r\n')
#bp35_uart = machine.UART(2, rx=13, tx=12, baudrate=115200, lineend='\r\n')

bp35 = BP35A1(uart=bp35_uart, i2c=i2c, i2c_addr=0x64)

bp35_state = ''

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
            pdc = self._m[offset + 1]
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
        return self._m[:self._next_offset]
            
# Construct ECHONETlite request frame
getPropertyFrame = EchonetLiteFrame(bytearray(64))
getPropertyFrame.init()
getPropertyFrame.tid(0x0000)            # TID = 0x0000
getPropertyFrame.seoj(b'\x05\xff\x01')  # SEOJ 送信元EOJ クラスグループ=管理・操作関連機器, クラス=コントローラ
getPropertyFrame.deoj(b'\x02\x88\x01')  # DEOJ 送信先EOJ クラスグループ=住宅・設備関連機器, クラス=低圧スマート電力量メータ
getPropertyFrame.esv(EchonetLiteFrame.ESV_GET)  # プロパティ読み出し要求
getPropertyFrame.add_property(0xd3, None)   # 係数
getPropertyFrame.add_property(0xe0, None)   # 積算電力量計測値
getPropertyFrame.add_property(0xe1, None)   # 積算電力量単位
getPropertyFrame.add_property(0xe7, None)   # 瞬時電力計測値
getPropertyFrame.add_property(0xe8, None)   # 瞬時電流計測値

last_instant_power = None
last_instant_current = None

async def main_task():
    global bp35_state
    global last_instant_power,last_instant_current
    while True:
        bp35_state = 'Initializing'
        gc.collect()
        if not await bp35.reset():
            log.error('Failed to reset the Wi-SUN module.')
            bp35_state = 'Error'
            await asyncio.sleep(1)
            continue
        
        if not await bp35.set_password(appconfig.password, timeout=5000):
            log.error('Failed to set password.')
            continue
        if not await bp35.set_route_b_id(appconfig.id, timeout=5000):
            log.error('Failed to set route-b ID.')
            continue

        while True:
            gc.collect()
            bp35_state = 'Scanning'
            log.info("Scanning PANs...")
            success, pans = await bp35.scan(0xffffffff, 6, timeout=1000, scan_timeout=30000)
            if success:
                log.info("PANs detected: {0}".format(pans))
                break
            else:
                log.error("Failed to scan PANs")

        if len(pans) == 0:
            continue
        
        ## Connecting
        gc.collect()
        bp35_state = 'Connecting'
        pan = pans[0] # type: Dict[bytes, bytes]
        if not (b'Channel' in pan and b'Pan ID' in pan and b'Addr' in pan):
            log.error("Invalid PAN information")
            continue

        channel     = int(str(pan[b'Channel'], 'utf-8'), 16)
        pan_id      = str(pan[b'Pan ID'], 'utf-8')
        mac_address = str(pan[b'Addr'], 'utf-8')
        
        if not await bp35.set_channel(channel, timeout=1000):
            log.error("Failed to set channel.")
            continue
        if not await bp35.set_pan_id(pan_id, timeout=1000):
            log.error("Failed to set PAN ID")
            continue
        ll_address = await bp35.get_link_local_address(mac_address, timeout=1000)
        if ll_address is None:
            log.error("Failed to get link local address")
            continue
        
        gc.collect()
        if not await bp35.connect_to(ll_address, timeout=10000):
            log.error("Failed to connect to the coordinator.")
            continue
        
        gc.collect()
        bp35_state = 'Connected'
        response_buffer = bytearray(3072)
        while True:
            if await bp35.send_to(True, ll_address, 0xe1a, getPropertyFrame.bytes(), timeout=10000):
                response = await bp35.receive(response_buffer, timeout=10000)
                if response is not None:
                    frame = EchonetLiteFrame(response)
                    if frame.is_valid():
                        seoj = frame.seoj()
                        esv  = frame.esv()
                        
                        log.debug("seoj={0}, esv={1}".format(seoj, esv))
                        if seoj == b'\x02\x88\x01' and esv == EchonetLiteFrame.ESV_GET_RES: # レスポンスはプロパティ読み取り要求の応答?
                            for mv in frame.target_properies():
                                if mv[0] == 0xe7 and mv[1] == 4 and len(mv) == 6:   # 瞬時電力量
                                    power = struct.unpack('>i', mv[2:])[0]
                                    log.info('Power={0}[W]'.format(power))
                                    last_instant_power = power
                                elif mv[0] == 0xe8 and mv[1] == 4 and len(mv) == 6:   # 瞬時電流
                                    current_r, current_t = struct.unpack('>hh', mv[2:])
                                    log.info('Current R={0},T={1}[dA]'.format(current_r, current_t))
                                    last_instant_current = (current_r, current_t)
                            
                            await asyncio.sleep(10)     


    

# asyncio.set_debug(True)
# asyncio.core.set_debug(True)

lcd.clear()
async def display_task():
    while True:
        lcd.font(lcd.FONT_DejaVu24)
        lcd.rect(0, 0, 320, 60, 0, 0)
        lcd.text(0, 0, 'BP35A1: ' + bp35_state)
        if last_instant_power is not None:
            lcd.text(0, 20, 'Power: {0}'.format(last_instant_power))
        if last_instant_current is not None:
            lcd.text(0, 40, 'Current R, T: {0}, {1}'.format(last_instant_current[0]//10, last_instant_current[1]//10))
        await asyncio.sleep_ms(100)

loop = asyncio.get_event_loop()
loop.create_task(display_task())
loop.create_task(main_task())
loop.run_forever()

    
