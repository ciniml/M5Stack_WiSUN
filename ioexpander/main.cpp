/*
 * ioexpander.cpp
 *
 * Author : Kenta IDA
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include <avr/sleep.h>

#define DEFINE_PORT_DEF(port) \
struct Port##port { \
	static inline void set_port_bit(uint8_t bit) { PORT##port |= _BV(bit); } \
	static inline void clear_port_bit(uint8_t bit) { PORT##port &= ~_BV(bit); } \
	static inline void set_ddr_bit(uint8_t bit) { DDR##port |= _BV(bit); } \
	static inline void clear_ddr_bit(uint8_t bit) { DDR##port &= ~_BV(bit); } \
	static inline uint8_t read_port() { return PORT##port; } \
	static inline uint8_t read_ddr() { return DDR##port; } \
	static inline uint8_t read_pin() { return PIN##port; } \
};

//DEFINE_PORT_DEF(A)
DEFINE_PORT_DEF(B)
DEFINE_PORT_DEF(C)
DEFINE_PORT_DEF(D)

template<typename portdef, uint8_t bit>
struct Pin 
{

	static inline void as_output(bool initial) 
	{ 
		if( initial ) {
			portdef::set_port_bit(bit);
			} else {
			portdef::clear_port_bit(bit);
		}
		portdef::set_ddr_bit(bit);
	}
	static inline void as_input(bool pullup) 
	{ 
		portdef::clear_ddr_bit(bit); 
		if( pullup ) {
			portdef::set_port_bit(bit);
		} else {
			portdef::clear_port_bit(bit);
		}
	}
	static inline void output(bool value) 
	{
		if( value ) {
			portdef::set_port_bit(bit);
		} else {
			portdef::clear_port_bit(bit);
		}
	}
	static inline bool input() 
	{
		return (portdef::read_pin() & _BV(bit)) != 0;
	}
};

typedef Pin<PortD, 7> PIN_BP35_RTS;
typedef Pin<PortD, 6> PIN_BP35_CTS;
typedef Pin<PortD, 5> PIN_PD5;
typedef Pin<PortD, 4> PIN_PD4;
typedef Pin<PortD, 3> PIN_BP35_RESET;
typedef Pin<PortD, 2> PIN_BP35_WKUP;
typedef Pin<PortD, 1> PIN_TXD0;
typedef Pin<PortD, 0> PIN_RXD0;

typedef Pin<PortC, 5> PIN_SCL;
typedef Pin<PortC, 4> PIN_SDA;

struct I2CRegisterData 
{
	uint8_t signature;
	uint8_t moduleInputs;
	uint8_t moduleOutputs;
	uint8_t reserved;
};
static volatile I2CRegisterData i2cRegisters = {
	0xa5,
	0x00,
	0x00,
};
static const uint8_t i2cRegisterWriteMasks[sizeof(I2CRegisterData)] = {
	0x00,
	0x00,
	0xff,
	0x00,
};

static volatile uint8_t* i2cRegisterHead = reinterpret_cast<volatile uint8_t*>(&i2cRegisters);
static const uint8_t i2cRegisterSize = sizeof(I2CRegisterData);
static volatile bool i2cRegisterUpdated = false;

ISR(TWI0_vect) 
{
	static uint8_t registerAddress = 0;
	static bool addressRecognized = false;
	
	switch(TWSR0 & 0xf8) {
		case 0xA8:	// Own SLA+R
		case 0xB8:	// DATA transmitted, ACK returned
			if(addressRecognized && registerAddress < i2cRegisterSize ) {
				TWDR0 = *(i2cRegisterHead + registerAddress);
				++registerAddress;
			} else {
				TWDR0 = 0;	
			}
			break;
		case 0x60:	// Own SLA+W
			addressRecognized = false;
			break;
		case 0x80:	// DATA received, ACK returned
		case 0x88:	// DATA received, NACK returned
			if( !addressRecognized ) {
				addressRecognized = true;
				registerAddress = TWDR0;
			} else {
				if( registerAddress < i2cRegisterSize ) {
					uint8_t mask = *(i2cRegisterWriteMasks + registerAddress);
					uint8_t value = *(i2cRegisterHead + registerAddress);
					*(i2cRegisterHead + registerAddress) = (value & ~mask) | (TWDR0 & mask);
					i2cRegisterUpdated = true;
					++registerAddress;
				}
			}
			TWCR0 |= _BV(TWEA);
			break;
		case 0xA0: // STOP or RS condition
			TWCR0 |= _BV(TWEA);
			break;
		case 0x00:	// BUS ERROR
			TWCR0 |= _BV(TWEA) | _BV(TWSTO);
			break;
		default:
			TWCR0 |= _BV(TWEA);
			break;
		
	}
	TWCR0 |= _BV(TWINT);	// Clear interrupt flag.
}

static void twiInitialize(uint8_t address) 
{
	TWCR0 = 0;
	
	TWSR0 = 0;
	TWBR0 = F_CPU / (100*1000UL);
	TWAR0 = address << 1;
	TWAMR0 = 0;
	
	TWCR0 = _BV(TWEA) | _BV(TWEN) | _BV(TWIE);	
}

int main(void)
{
	PIN_RXD0::as_input(true);
	PIN_TXD0::as_input(true);
	PIN_BP35_WKUP::as_output(false);
	PIN_BP35_RESET::as_output(false);
	PIN_PD4::as_input(true);
	PIN_PD5::as_input(true);
	PIN_BP35_CTS::as_input(true);
	PIN_BP35_RTS::as_output(true);
	
	// Enable I2C bus pull-up
	PIN_SDA::as_input(true);
	PIN_SCL::as_input(true);
	
	// Initialize TWI
	twiInitialize(0x64);
	
	sei();
	set_sleep_mode( SLEEP_MODE_IDLE );
    while (1) 
    {
		sleep_enable();
		sei();
		sleep_cpu();
		sleep_disable();
		cli();
		
		if( i2cRegisterUpdated ) {
			i2cRegisterUpdated = false;
			uint8_t output = i2cRegisters.moduleOutputs;
			PIN_BP35_WKUP::output(output & 1);
			PIN_BP35_RESET::output(output & 2);
			PIN_BP35_RTS::output(output & 4);
		}
		{
			uint8_t input = 0;
			input |= PIN_BP35_CTS::input() ? 0 : 1;
			i2cRegisters.moduleInputs = input;
		}
		
    }
}

