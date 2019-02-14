"""
TI PCA series I2C I/O expander driver
Copyright 2019 Kenta IDA
License: Boost Software License
"""

try:
    from mpy_builtins import machine, const
    from typing import Tuple, Callable, List, Dict, Optional, Union, Generator, Optional
except:
    import machine

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
    


