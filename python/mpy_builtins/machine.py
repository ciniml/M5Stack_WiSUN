"""
machine module in MicroPython
"""

from typing import Dict, Tuple, List, Callable

def soft_reset() -> None:
    pass

class I2C(object):
    def __init__(self, id=-1, *args, scl, sda, freq:int=400000):
        pass
    def init(self, scl, sda, freq:int=400000):
        pass
    def deinit(self):
        pass
    def scan(self) -> List[int]:
        pass

    def readfrom(self, addr:int, nbytes:int, stop:bool=True) -> bytes:
        pass
    def readfrom_into(self, addr:int, buf:bytearray, stop:bool=True) -> int:
        pass
    def writeto(self, addr:int, buf:bytes, stop:bool=True) -> int:
        pass

    def readfrom_mem(self, addr:int, memaddr:int, nbytes:int, addrsize:int=8) -> bytes:
        pass
    def readfrom_mem_into(self, addr:int, memaddr:int, buf:bytearray, addrsize:int=8) -> None:
        pass
    def writeto_mem(self, addr:int, memaddr:int, buf:bytes, addrsize:int=8) -> None:
        pass



def delay(ms:int)->None:
    pass
def udelay(ms:int)->None:
    pass
def millis()->int:
    return 0
def micros()->int:
    return 0
def elapsed_millis(start:int)->int:
    return start
def elapsed_micros(start:int)->int:
    return start
def hard_reset()->None:
    pass
def bootloader()->None:
    pass
def fault_debug(value:bool)->None:
    pass
def disable_irq()->None:
    pass
def enable_irq(state:bool=True)->None:
    pass
def freq(sysclk:int=None, hclk:int=None, pclk1:int=None, pclk2:int=None)->None:
    pass
def wfi()->None:
    "Wait for an internal or external interrupt"
    pass
def standby()->None:
    pass

def have_cdc()->bool:
    return True
def info(dump_alloc_table:bool=None)->None:
    pass
def main(filename:str)->None:
    pass
def mount(device, mountpoint:str, *args, readonly:bool=False, mkfs:bool=False)->None:
    pass
def repl_uart(uart)->None:
    pass
def rng()->int:
    return 0
def sync()->None:
    pass
def unique_id()->str:
    return 'uniqueid0000'

class Pin(object):
    IN = 0
    OUT = 1
    OUT_OD = 2

    PULL_NONE = 0
    PULL_UP = 1
    PULL_DOWN = 2

    @classmethod
    def debug(cls, state:bool=True)->None:
        pass
    @classmethod
    def dict(cls, dict:Dict[str,str]=None)->Dict[str,str]:
        pass
    @classmethod
    def mapper(cls, func:Callable[[str],str]=None)->Callable[[str],str]:
        pass
    
    def __init__(self, id:str, **kwargs):
        self.__id = id
    
    def init(self, mode:int, pull:int=Pin.PULL_NONE, af:int=-1)->None:
        pass
    def value(self, value:bool=None)->bool:
        return None if value is not None else False
    def __str__(self)->str:
        return self.__id
    def af(self)->int:
        return 0
    
    def on(self)->None:
        pass
    def off(self)->None:
        pass

class UART(object):
    RTS = 256
    CTS = 512
    
    def __init__(self, bus:int, **kwargs):
        self.__bus = bus
    def init(self, baudrate:int, bits:int=8, parity:int=None, stop:int=1, *args, timeout:int=1000, flow:int=0, timeout_char:int=0, read_buf_len:int=64) -> None:
        pass
    def deinit(self) -> None:
        pass
    def any(self) -> int:
        return 0
    def read(self, nbytes:int=None) -> bytes:
        return bytes([])
    def readchar(self) -> int:
        return 0
    def readinto(self, buf:bytearray, nbytes:int=None) -> int:
        return 0
    def readline(self) -> bytes:
        return None
    def write(self, buf:bytes) -> int:
        return None
    def writechar(self, char:int) -> None:
        return None
    def sendbreak(self) -> None:
        return None
