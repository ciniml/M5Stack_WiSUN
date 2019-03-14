"""
Main module for M5Stack-WiSUN Expansion board sample application.
License: Boost Software License
"""
try:
    from mpy_builtins import machine, const
    from typing import Tuple, Callable, List, Dict, Optional, Union, Generator, Optional
except:
    from m5stack import lcd
    import machine
    import network
    import time
    from machine import reset
    from urequests import request, Response

import gc
import logging
import uasyncio as asyncio
from bp35 import BP35A1
import struct
import appconfig
from ioexpander import IOExpander

def reset(): 
    machine.reset()

# Configure logger.
logging.basicConfig(logging.DEBUG)
log = logging.Logger('MAIN')

# Synchronize time
rtc = machine.RTC()
rtc.ntp_sync(server='ntp.jst.mfeed.ad.jp',tz='JST')

# Configure IOExpander
i2c_scl = machine.Pin(22)
i2c_sda = machine.Pin(21)
i2c = machine.I2C(scl=i2c_scl, sda=i2c_sda)
ioe = IOExpander(i2c=i2c, address=24, output=0x03, inversion=0x00, direction=0xfc)

# Initialize BP35A1 interfaces
#bp35_wkup  = machine.Pin(12, machine.Pin.OUT)
#bp35_reset = machine.Pin(13, machine.Pin.OUT)
bp35_wkup = ioe.pin(0)
bp35_reset = ioe.pin(1)
bp35_uart = machine.UART(1, rx=2, tx=5, baudrate=115200, lineend='\r\n')

bp35 = BP35A1(uart=bp35_uart, wkup=bp35_wkup, reset=bp35_reset)

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


def post_json(endpoint:str, json:str) -> bool:
    try:
        r = request('POST', endpoint, data=json, headers={'Content-Type':'application/json'}) # type:Response
        r.close()
        return 200 <= r.status_code and r.status_code < 300
    except:
        log.error('Failed to post data to PowerBI')
        return False

last_instant_power = None
last_instant_current = None
last_cumulative_power = None
async def main_task():
    global bp35_state
    global last_instant_power,last_instant_current,last_cumulative_power
    
    while True:
        bp35_state = 'Initializing'
        gc.collect()
        if not await bp35.reset():
            log.error('Failed to reset the Wi-SUN module.')
            bp35_state = 'Error'
            await asyncio.sleep(1)
            continue
        
        if not await bp35.set_password(appconfig.route_b_password, timeout=5000):
            log.error('Failed to set password.')
            continue
        if not await bp35.set_route_b_id(appconfig.route_b_id, timeout=5000):
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
        response_buffer = bytearray(1024)
        prev_last_instant_power = 0.0
        no_post_count = 0
        no_response_count = 0
        no_response_reset_count = 0
        harvest_endpoint = 'https://api.soracom.io/v1/devices/{0}/publish?device_secret={1}'.format(appconfig.inventory_id, appconfig.inventory_password)
        while True:
            if await bp35.send_to(True, ll_address, 0xe1a, getPropertyFrame.bytes(), timeout=10000):
                response = await bp35.receive(response_buffer, timeout=10000)
                if response is None:
                    no_response_count += 1
                    if no_response_count >= 6: # 6回連続でレスポンスが無かったらリセットする。
                        log.info("No response. Perform reset.")
                        no_response_reset_count += 1
                        break
                else:
                    no_response_count = 0
                    frame = EchonetLiteFrame(response)
                    if frame.is_valid():
                        seoj = frame.seoj()
                        esv  = frame.esv()
                        
                        coefficient = 1
                        cumulative_unit = 1.0
                        cumulative_value = None

                        log.debug("seoj={0}, esv={1}".format(seoj, esv))
                        if seoj == b'\x02\x88\x01' and esv == EchonetLiteFrame.ESV_GET_RES: # レスポンスはプロパティ読み取り要求の応答?
                            for mv in frame.target_properies():
                                if mv[0] == PROPERTY_INSTANT_POWER and mv[1] == 4 and len(mv) == 6:   # 瞬時電力量
                                    power = struct.unpack('>i', mv[2:])[0]
                                    log.info('Power={0}[W]'.format(power))
                                    last_instant_power = power
                                elif mv[0] == PROPERTY_INSTANT_CURRENT and mv[1] == 4 and len(mv) == 6:   # 瞬時電流
                                    current_r, current_t = struct.unpack('>hh', mv[2:])
                                    log.info('Current R={0},T={1}[dA]'.format(current_r, current_t))
                                    last_instant_current = (current_r, current_t)
                                elif mv[0] == PROPERTY_COEFFICIENT and mv[1] == 4 and len(mv) == 6: # 係数
                                    coefficient = struct.unpack('>I', mv[2:])[0]
                                    log.debug('Coefficient={0}'.format(coefficient))
                                elif mv[0] == PROPERTY_CUMULATIVE_UNIT and mv[1] == 1 and len(mv) == 3: # 単位
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
                                    log.debug('CumulativeUnit={0}'.format(cumulative_unit))
                                elif mv[0] == PROPERTY_CUMULATIVE_VALUE and mv[1] == 4 and len(mv) == 6: # 積算電力量
                                    cumulative_value = struct.unpack('>I', mv[2:])[0]
                                    log.debug('CumulativeValue={0}'.format(cumulative_value))
                            
                            if cumulative_value is not None:
                                last_cumulative_power = cumulative_value*cumulative_unit*coefficient
                                log.info('Cumulative Power={0}[kWh]'.format(last_cumulative_power))
                            
                            if last_instant_power is not None:
                                prev_last_instant_power = 1 if prev_last_instant_power < 1 else prev_last_instant_power
                                diff_percent = abs(last_instant_power - prev_last_instant_power) / prev_last_instant_power
                                if diff_percent < 0.1:
                                    no_post_count += 1
                                
                                if diff_percent >= 0.1 or no_post_count >= 30:
                                    prev_last_instant_power = last_instant_power
                                    timestamp = time.strftime('%Y-%m-%dT%H:%M:%S.000Z')
                                    log.info("POST: instant={0},cumulative={1},diff={2},no_post={3}".format(last_instant_power, last_cumulative_power, diff_percent, no_post_count))
                                    json = '{{"power":{0},"cumul":{1},"reset":{2},"timestamp":"{3}"}}'.format(last_instant_power, last_cumulative_power, no_response_reset_count, timestamp)
                                    log.debug(json)
                                    post_json(appconfig.powerbi_url, '[' + json + ']')
                                    post_json(harvest_endpoint, json)
                                    no_post_count = 0
                            
                            await asyncio.sleep(10)

# asyncio.set_debug(True)
# asyncio.core.set_debug(True)

lcd.clear()
async def display_task():
    while True:
        lcd.font(lcd.FONT_DejaVu24)
        fw, fh = lcd.fontSize()

        lcd.setTextColor(color=lcd.BLACK, bcolor=lcd.WHITE)
        lcd.text(0, 0, 'SmartMeter: ' + bp35_state + '\r')
        lcd.rect(0, fh, 320, 2, 0, 0)
        
        lcd.setTextColor(color=lcd.WHITE, bcolor=lcd.BLACK)
        lcd.text(319-fw*1, 90, 'W')
        lcd.text(319-fw*3, 150, 'kWh')

        lcd.font(lcd.FONT_7seg, transparent=False, dist=25, width=5, outline=False)
        sfw, sfh = lcd.fontSize()

        if last_instant_power is not None:
            if last_instant_power >= 1500:
                lcd.setTextColor(color=lcd.RED)
            else:
                lcd.setTextColor(color=lcd.WHITE)
            lcd.text(40, fh+4, '{0:04d}'.format(last_instant_power))
        else:
            lcd.setTextColor(color=lcd.WHITE)
            lcd.text(40, fh+4, '----')
        
        lcd.setTextColor(color=lcd.WHITE)
        lcd.rect(0, fh+sfh+4, 320, 2, 0xffffff, 0xffffff)
        lcd.font(lcd.FONT_7seg, transparent=False, dist=15, width=3, outline=False)
        
        if last_cumulative_power is not None:
            lcd.text(40, fh+sfh+10, '{0:06.1f}'.format(last_cumulative_power))
        else:
            lcd.text(40, fh+sfh+10, '------')

        lcd.rect(0, 180, 320, 2, 0xffffff, 0xffffff)

        # if last_instant_current is not None:
        #     lcd.text(0, font_size[1]*3, 'Current: R={0},T={1}[A]'.format(last_instant_current[0]/10,last_instant_current[1]/10))
        
        gc.collect()
        await asyncio.sleep_ms(100)

loop = asyncio.get_event_loop()
loop.create_task(display_task())
loop.create_task(main_task())
loop.run_forever()

    
