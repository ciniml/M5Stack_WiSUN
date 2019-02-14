"""
Setup development environment
"""

import time
import network
import machine
import gc

try:
    import appconfig
except:
    class AppConfig(object):
        def __init__(self, ssid:str, password:str) -> None:
            self.wifi_ssid = ssid
            self.wifi_password = password
    ssid = input('Input Wi-Fi SSID: ')
    password = input('Input Wi-Fi Password: ')
    appconfig = AppConfig(ssid, password)

# Start Wi-Fi
w = network.WLAN()
w.active(True)
w.connect(appconfig.wifi_ssid, appconfig.wifi_password)
while not w.isconnected():
    time.sleep(1)
print(w.ifconfig())

# Start FTP server to upload source codes.
network.ftp.start(user='esp32', password='esp32')
gc.collect()
