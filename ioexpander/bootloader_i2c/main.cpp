/*
 * main.cpp
 *
 * Author : Kenta IDA
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include <avr/sleep.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>

#if defined (__AVR_ATmega328__) || defined(__AVR_ATmega328P__) || defined(__AVR_ATmega328PB__)
typedef uint16_t PAGESIZE_t;
#define SIGNATURE { 0x1e, 0x95, 0x0f }
static const size_t BootloaderWords = 2048;
static const size_t FlashSize = (FLASHEND - (BootloaderWords*2) + 1);
static const PAGESIZE_t PageSize = SPM_PAGESIZE;
static const size_t NumberOfPages = FlashSize / PageSize;
#else
#error This AVR is not supported.
#endif

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
typedef Pin<PortD, 5> PIN_BOOT_APP;
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
	uint8_t control;
	uint8_t status;
	uint8_t updateKey;
	uint16_t pageSize;
};
static volatile I2CRegisterData i2cRegisters = {
	0x5a,
	0x00,
	0x00,
	0x00,
	PageSize,
};
static const uint8_t i2cRegisterWriteMasks[sizeof(I2CRegisterData)] = {
	0x00,
	0x01,
	0x00,
	0xff,
	0x00,	// pageSize
	0x00,	// /
};
static const uint8_t CONTROL_BOOT_APP = 0x01;
static const uint8_t STATUS_UPDATING_PAGE = 0x01;
static const uint8_t UPDATE_KEY = 0xac;

static volatile uint8_t* i2cRegisterHead = reinterpret_cast<volatile uint8_t*>(&i2cRegisters);
static const uint8_t i2cRegisterSize = sizeof(I2CRegisterData);
static volatile bool i2cRegisterUpdated = false;
static const uint16_t i2cRegisterOffset = 0x8000;
static volatile uint16_t pageBaseAddress = 0;
static volatile uint8_t pageBuffer[PageSize];

static bool isValidRegisterAddress(uint16_t address) {
	return i2cRegisterOffset <= address && address < i2cRegisterOffset + i2cRegisterSize;
}
static bool isValidFlashAddress(uint16_t address) {
	return address < FlashSize;
}

#ifdef __AVR_ATmega328PB__
ISR(TWI0_vect)
#elif __AVR_ATmega328P__
#define TWSR0  TWSR
#define TWCR0  TWCR
#define TWDR0  TWDR
#define TWAR0  TWAR
#define TWAMR0 TWAMR
ISR(TWI_vect)
#endif
{
	static uint16_t targetAddress = 0;
	static uint8_t addressBytesReceived = 0;
	static const uint8_t addressLength = sizeof(targetAddress);
	
	uint8_t twiState = TWSR0 & 0xf8;
	switch(twiState) {
		case 0xA8:	// Own SLA+R
		case 0xB8:	// DATA transmitted, ACK returned
			if(addressBytesReceived == addressLength ) {
				if( isValidRegisterAddress(targetAddress) ) {
					TWDR0 = *(i2cRegisterHead + targetAddress - i2cRegisterOffset);
					++targetAddress;
				}
				else if( isValidFlashAddress(targetAddress) ){
					TWDR0 = pgm_read_byte(targetAddress);
					++targetAddress;
				}
				else {
					TWDR0 = 0;
				}
			} else {
				TWDR0 = 0;	
			}
			break;
		case 0x60:	// Own SLA+W
			addressBytesReceived = 0;
			break;
		case 0x80:	// DATA received, ACK returned
		case 0x88:	// DATA received, NACK returned
			if( addressBytesReceived < addressLength ) {
				targetAddress = (targetAddress << 8) | TWDR0;
				addressBytesReceived++;
			} else {
				if( isValidRegisterAddress(targetAddress) ) {
					uint16_t registerAddress = targetAddress - i2cRegisterOffset;
					uint8_t mask = *(i2cRegisterWriteMasks + registerAddress);
					uint8_t value = *(i2cRegisterHead + registerAddress);
					*(i2cRegisterHead + registerAddress) = (value & ~mask) | (TWDR0 & mask);
					i2cRegisterUpdated = true;
					++targetAddress;
					//if( twiState == 0x80 ) {
						//if( isValidRegisterAddress(targetAddress) ) {
							//TWCR0 |= _BV(TWEA);
						//} 
						//else {
							//TWCR0 &= ~_BV(TWEA);
						//}
					//}
					//else {
						//TWCR0 |= _BV(TWEA);
					//}
				}
				else if( isValidFlashAddress(targetAddress) && !(i2cRegisters.status & STATUS_UPDATING_PAGE)){
					uint16_t offset = targetAddress & (PageSize - 1);
					pageBuffer[offset] = TWDR0;
					if( offset == (PageSize - 1) ) { // Page buffer is filled.
						pageBaseAddress = targetAddress & ~(PageSize - 1);
						i2cRegisters.status |= STATUS_UPDATING_PAGE;
						i2cRegisterUpdated = true;
					}
					++targetAddress;
					//if( twiState == 0x80 ) {
						//if( (offset + 1) < (PageSize - 1) ) {	// Is next byte not last?
							//TWCR0 |= _BV(TWEA);
						//}
						//else {
							//TWCR0 &= ~_BV(TWEA);	// The next byte is the last byte of the page. Return NACK at the next transfer.
						//}
					//}
					//else {
						//TWCR0 |= _BV(TWEA);
					//}
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
	TWSR0 = 0;
#if __AVR_ATmega328PB__
	TWBR0 = F_CPU / (100*1000UL);
#elif__AVR_ATmega328P__
	TWBR = F_CPU / (100*1000UL);
#endif
	TWAR0 = address << 1;
	TWAMR0 = 0;
	TWCR0 = _BV(TWEA) | _BV(TWEN) | _BV(TWIE);	
}

int main(void)
{
	// Set interrupt vector to bootloader section
	MCUCR = _BV(IVCE);
	MCUCR = _BV(IVSEL);
	
	// Initialize I/O vector
	PIN_RXD0::as_input(true);
	PIN_TXD0::as_input(true);
	PIN_BP35_WKUP::as_output(false);
	PIN_BP35_RESET::as_output(false);
	PIN_PD4::as_input(true);
	PIN_BOOT_APP::as_input(true);
	PIN_BP35_CTS::as_input(true);
	PIN_BP35_RTS::as_output(false);
	
	// Enable I2C bus pull-up
	PIN_SDA::as_input(true);
	PIN_SCL::as_input(true);
	
	// Initialize TWI
	twiInitialize(0x65);
	
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
			if( i2cRegisters.status & STATUS_UPDATING_PAGE ) {
				if( i2cRegisters.updateKey == UPDATE_KEY ) {
					// Update the target page.
					cli();
					boot_page_erase(pageBaseAddress);
					sei();
					boot_spm_busy_wait();
				
					for(uint16_t i = 0; i < PageSize; i+=2) {
						cli();
						boot_page_fill(pageBaseAddress + i, *reinterpret_cast<volatile uint16_t*>(pageBuffer + i));
						sei();
					}
					cli();
					boot_page_write(pageBaseAddress);
					sei();
					boot_spm_busy_wait();	
				}
				i2cRegisters.status &= ~STATUS_UPDATING_PAGE;
			}
			else {
				if( i2cRegisters.control & CONTROL_BOOT_APP ) {
					// Boot application 
					cli();
					boot_rww_enable();
					MCUCR = _BV(IVCE);
					MCUCR = 0;
					(reinterpret_cast<void(*)()>(0))();	// Jump to reset vector.
				}
			}
		}
    }
}

