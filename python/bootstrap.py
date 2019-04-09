"""
Setup development environment
"""

import time
import network
import machine
import gc
import m5stack

wifi_cancelled = m5stack.buttonC.isPressed() # type: bool

try:
    import appconfig
except:
    class AppConfig(object):
        def __init__(self, ssid:str, password:str) -> None:
            self.wifi_ssid = ssid
            self.wifi_password = password
    if not wifi_cancelled:
        ssid = input('Input Wi-Fi SSID: ')
        password = input('Input Wi-Fi Password: ')
    else:
        ssid = ''
        password = ''
    appconfig = AppConfig(ssid, password)

# Start Wi-Fi
if not wifi_cancelled:
    s = 'Connecting to Wi-Fi AP {0}... Press C to cancel'.format(appconfig.wifi_ssid)
    m5stack.lcd.print(s)
    print(s)
    w = network.WLAN()
    w.active(True)
    w.connect(appconfig.wifi_ssid, appconfig.wifi_password)
    while not w.isconnected() and not wifi_cancelled:
        wifi_cancelled = m5stack.buttonC.isPressed()
        time.sleep(1)

if not wifi_cancelled:
    print(w.ifconfig())
    # Start FTP server to upload source codes.
    network.ftp.start(user='esp32', password='esp32')

m5stack.lcd.clear()
gc.collect()
