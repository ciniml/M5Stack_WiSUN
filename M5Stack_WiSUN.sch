EESchema Schematic File Version 4
LIBS:M5Stack_WiSUN-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "M5Stack Wi-SUN Stack"
Date "2018-09-01"
Rev "Rev.A"
Comp "Kenta IDA"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_ATmega:ATmega328P-AU U2
U 1 1 5B0D85A4
P 8700 4100
F 0 "U2" H 8650 4150 50  0000 C CNN
F 1 "ATMEGA328P-AU" H 8700 4050 50  0000 C CNN
F 2 "Package_QFP:LQFP-32_7x7mm_P0.8mm" H 8700 4100 50  0001 C CIN
F 3 "" H 8700 4100 50  0001 C CNN
F 4 "ATMEGA328PB-MUR" H -300 0   50  0001 C CNN "MPN"
F 5 "Microchip" H -300 0   50  0001 C CNN "Manufacturer"
F 6 "ATMEGA328PB-MURCT-ND" H -300 0   50  0001 C CNN "SKU"
F 7 "Digikey" H -300 0   50  0001 C CNN "Supplier"
F 8 "ATMEGA328P-MU" H -700 -100 50  0001 C CNN "PCBA-MPN"
F 9 "Atmel" H -700 -100 50  0001 C CNN "PCBA-Manufacturer"
	1    8700 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 5B0D8760
P 8700 5600
F 0 "#PWR015" H 8700 5350 50  0001 C CNN
F 1 "GND" H 8705 5427 50  0000 C CNN
F 2 "" H 8700 5600 50  0001 C CNN
F 3 "" H 8700 5600 50  0001 C CNN
	1    8700 5600
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR014
U 1 1 5B0D8791
P 8700 2050
F 0 "#PWR014" H 8700 1900 50  0001 C CNN
F 1 "+3.3V" H 8715 2223 50  0000 C CNN
F 2 "" H 8700 2050 50  0001 C CNN
F 3 "" H 8700 2050 50  0001 C CNN
	1    8700 2050
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J4
U 1 1 5B0D8FED
P 10050 1200
F 0 "J4" H 10050 1515 50  0000 C CNN
F 1 "ISP" H 10050 1424 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" H 10050 0   50  0001 C CNN
F 3 "" H 10050 0   50  0001 C CNN
	1    10050 1200
	1    0    0    -1  
$EndComp
Text Label 9850 1100 2    60   ~ 0
AVR_MISO
Text Label 9850 1200 2    60   ~ 0
AVR_SCK
Text Label 10350 1200 0    60   ~ 0
AVR_MOSI
Text Label 9850 1300 2    60   ~ 0
AVR_RESET
$Comp
L power:+3.3V #PWR023
U 1 1 5B0D9229
P 10450 1100
F 0 "#PWR023" H 10450 950 50  0001 C CNN
F 1 "+3.3V" H 10465 1273 50  0000 C CNN
F 2 "" H 10450 1100 50  0001 C CNN
F 3 "" H 10450 1100 50  0001 C CNN
	1    10450 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR024
U 1 1 5B0D925C
P 10450 1300
F 0 "#PWR024" H 10450 1050 50  0001 C CNN
F 1 "GND" H 10455 1127 50  0000 C CNN
F 2 "" H 10450 1300 50  0001 C CNN
F 3 "" H 10450 1300 50  0001 C CNN
	1    10450 1300
	1    0    0    -1  
$EndComp
Text Label 9300 4400 0    60   ~ 0
AVR_RESET
Text Label 9300 4200 0    60   ~ 0
SDA
Text Label 9300 4300 0    60   ~ 0
SCL
$Comp
L Connector_Generic:Conn_02x15_Odd_Even J1
U 1 1 5B0DA09F
P 2200 3350
F 0 "J1" H 2200 4265 50  0000 C CNN
F 1 "MBUS_TOP" H 2200 4174 50  0000 C CNN
F 2 "local:MBUS_Header" H 2200 2200 50  0001 C CNN
F 3 "" H 2200 2200 50  0001 C CNN
	1    2200 3350
	-1   0    0    -1  
$EndComp
Text Label 9300 3300 0    60   ~ 0
AVR_MISO
Text Label 9300 3200 0    60   ~ 0
AVR_MOSI
Text Label 9300 3400 0    60   ~ 0
AVR_SCK
Text Label 1900 2950 2    60   ~ 0
MOSI
Text Label 1900 3050 2    60   ~ 0
MISO
Text Label 1900 3150 2    60   ~ 0
SCK
Text Label 1900 3250 2    60   ~ 0
RXD0
Text Label 1900 3350 2    60   ~ 0
RXD2
Text Label 1900 3450 2    60   ~ 0
SDA
Text Label 1900 3550 2    60   ~ 0
GPIO_G2
Text Label 1900 3650 2    60   ~ 0
IIS_SK
Text Label 1900 3750 2    60   ~ 0
IIS_OUT
Text Label 1900 3850 2    60   ~ 0
HPWR
Text Label 1900 3950 2    60   ~ 0
HPWR
Text Label 1900 4050 2    60   ~ 0
HPWR
Text Label 2400 4050 0    60   ~ 0
BATTERY
Text Label 2400 3850 0    60   ~ 0
IIS_IN
Text Label 2400 3750 0    60   ~ 0
IIS_MK
Text Label 2400 3650 0    60   ~ 0
IIS_WS
Text Label 2400 3550 0    60   ~ 0
GPIO_G5
Text Label 2400 3450 0    60   ~ 0
SCL
Text Label 2400 3350 0    60   ~ 0
TXD2
Text Label 2400 3250 0    60   ~ 0
TXD0
Text Label 2400 3050 0    60   ~ 0
DAC
Text Label 2400 2950 0    60   ~ 0
DAC_SPK
Text Label 2400 2850 0    60   ~ 0
RST
Text Label 2400 2750 0    60   ~ 0
ADC_G36
Text Label 2400 2650 0    60   ~ 0
ADC_G35
$Comp
L power:GND #PWR01
U 1 1 5B0DAF09
P 1650 2550
F 0 "#PWR01" H 1650 2300 50  0001 C CNN
F 1 "GND" H 1655 2377 50  0000 C CNN
F 2 "" H 1650 2550 50  0001 C CNN
F 3 "" H 1650 2550 50  0001 C CNN
	1    1650 2550
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR03
U 1 1 5B0DB0DB
P 2950 3150
F 0 "#PWR03" H 2950 3000 50  0001 C CNN
F 1 "+3.3V" H 2965 3323 50  0000 C CNN
F 2 "" H 2950 3150 50  0001 C CNN
F 3 "" H 2950 3150 50  0001 C CNN
	1    2950 3150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR04
U 1 1 5B0DB1BB
P 2950 3950
F 0 "#PWR04" H 2950 3800 50  0001 C CNN
F 1 "+5V" H 2965 4123 50  0000 C CNN
F 2 "" H 2950 3950 50  0001 C CNN
F 3 "" H 2950 3950 50  0001 C CNN
	1    2950 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	10450 1300 10350 1300
Wire Wire Line
	10450 1100 10350 1100
Wire Wire Line
	10350 1200 10800 1200
Wire Wire Line
	9400 1300 9850 1300
Wire Wire Line
	9400 1200 9850 1200
Wire Wire Line
	9400 1100 9850 1100
Wire Wire Line
	9300 4400 9750 4400
Wire Wire Line
	9300 3400 9700 3400
Wire Wire Line
	9300 3300 9700 3300
Wire Wire Line
	9300 3200 9700 3200
Wire Wire Line
	9300 4300 9550 4300
Wire Wire Line
	9300 4200 9550 4200
Wire Wire Line
	1850 2850 1900 2850
Wire Wire Line
	1900 2750 1850 2750
Connection ~ 1850 2750
Wire Wire Line
	1900 2650 1850 2650
Wire Wire Line
	2950 3150 2400 3150
Wire Wire Line
	2950 3950 2400 3950
Wire Wire Line
	2800 2650 2400 2650
Wire Wire Line
	1900 3050 1500 3050
Wire Wire Line
	1900 3150 1500 3150
Wire Wire Line
	1900 3250 1500 3250
Wire Wire Line
	1900 3350 1500 3350
Wire Wire Line
	1900 3450 1500 3450
Wire Wire Line
	1900 3550 1500 3550
Wire Wire Line
	1900 3650 1500 3650
Wire Wire Line
	1900 3750 1500 3750
Wire Wire Line
	1900 3850 1500 3850
Wire Wire Line
	1900 3950 1500 3950
Wire Wire Line
	1900 4050 1500 4050
Wire Wire Line
	2800 2750 2400 2750
Wire Wire Line
	2800 2850 2400 2850
Wire Wire Line
	2800 2950 2400 2950
Wire Wire Line
	2800 3050 2400 3050
Wire Wire Line
	2800 3250 2400 3250
Wire Wire Line
	2800 3350 2400 3350
Wire Wire Line
	2800 3450 2400 3450
Wire Wire Line
	2800 3550 2400 3550
Wire Wire Line
	2800 3650 2400 3650
Wire Wire Line
	2800 3750 2400 3750
Wire Wire Line
	2800 3850 2400 3850
Wire Wire Line
	2800 4050 2400 4050
Wire Wire Line
	1900 2950 1500 2950
$Comp
L Device:C_Small C1
U 1 1 5B0DD6E3
P 7450 3050
F 0 "C1" H 7542 3096 50  0000 L CNN
F 1 "100n" H 7542 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7450 3050 50  0001 C CNN
F 3 "" H 7450 3050 50  0001 C CNN
F 4 "GRM155R61C104KA88D" H -600 -700 50  0001 C CNN "MPN"
F 5 "490-5415-1-ND" H -600 -700 50  0001 C CNN "SKU"
F 6 "Digikey" H -600 -700 50  0001 C CNN "Supplier"
F 7 "Murata" H -600 -700 50  0001 C CNN "Manufacturer"
F 8 "CC0402KRX7R8BB104" H -700 -100 50  0001 C CNN "PCBA-MPN"
F 9 "Yageo" H -700 -100 50  0001 C CNN "PCBA-Manufacturer"
	1    7450 3050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7450 2900 7450 2950
$Comp
L power:GND #PWR012
U 1 1 5B0DD83D
P 7450 3150
F 0 "#PWR012" H 7450 2900 50  0001 C CNN
F 1 "GND" H 7455 2977 50  0000 C CNN
F 2 "" H 7450 3150 50  0001 C CNN
F 3 "" H 7450 3150 50  0001 C CNN
	1    7450 3150
	1    0    0    -1  
$EndComp
Text Label 9300 4600 0    60   ~ 0
AVR_RXD0
Text Label 9300 4800 0    60   ~ 0
BP35_WKUP
Text Label 9300 4900 0    60   ~ 0
BP35_RESET
Text Label 9300 5000 0    60   ~ 0
AVR_PD4
Text Label 9300 4700 0    60   ~ 0
AVR_TXD0
Text Label 9300 5100 0    60   ~ 0
AVR_PD5
Text Label 9300 5300 0    60   ~ 0
BP35_RTS
Wire Wire Line
	9300 5300 9850 5300
Wire Wire Line
	9300 5100 9850 5100
Wire Wire Line
	9300 5000 9850 5000
Wire Wire Line
	9300 4900 9850 4900
Wire Wire Line
	9300 4800 9850 4800
Wire Wire Line
	9300 4700 9850 4700
Wire Wire Line
	9300 4600 9850 4600
Wire Wire Line
	9300 4100 9850 4100
Text Label 9300 4100 0    60   ~ 0
AVR_ADC3
Text Label 9300 4000 0    60   ~ 0
AVR_ADC2
Text Label 9300 3900 0    60   ~ 0
AVR_ADC1
Text Label 9300 3800 0    60   ~ 0
AVR_ADC0
Text Label 9300 3600 0    60   ~ 0
AVR_PB7
Text Label 9300 3500 0    60   ~ 0
AVR_PB6
Text Label 9300 3100 0    60   ~ 0
AVR_PB2
Text Label 9300 3000 0    60   ~ 0
AVR_PB1
Text Label 9300 2900 0    60   ~ 0
AVR_PB0
Wire Wire Line
	9300 4000 9850 4000
Wire Wire Line
	9300 3900 9850 3900
Wire Wire Line
	9300 3800 9850 3800
Wire Wire Line
	9300 3600 9850 3600
Wire Wire Line
	9300 3500 9850 3500
Wire Wire Line
	9300 3100 9850 3100
Wire Wire Line
	9300 3000 9850 3000
Wire Wire Line
	9300 2900 9850 2900
Wire Wire Line
	6650 1450 7200 1450
Wire Wire Line
	6650 1050 7200 1050
Text Label 6650 1050 0    60   ~ 0
AVR_ADC3
Text Label 6650 1150 0    60   ~ 0
AVR_ADC2
Text Label 6650 1250 0    60   ~ 0
AVR_ADC1
Text Label 6650 1350 0    60   ~ 0
AVR_ADC0
Wire Wire Line
	6650 1150 7200 1150
Wire Wire Line
	6650 1250 7200 1250
Wire Wire Line
	6650 1350 7200 1350
$Comp
L power:GND #PWR011
U 1 1 5B0E068D
P 7100 1900
F 0 "#PWR011" H 7100 1650 50  0001 C CNN
F 1 "GND" H 7105 1727 50  0000 C CNN
F 2 "" H 7100 1900 50  0001 C CNN
F 3 "" H 7100 1900 50  0001 C CNN
	1    7100 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR09
U 1 1 5B0E06D8
P 6500 1650
F 0 "#PWR09" H 6500 1500 50  0001 C CNN
F 1 "+3.3V" H 6515 1823 50  0000 C CNN
F 2 "" H 6500 1650 50  0001 C CNN
F 3 "" H 6500 1650 50  0001 C CNN
	1    6500 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 1850 7100 1850
Wire Wire Line
	7100 1850 7100 1900
$Comp
L Device:L_Small L1
U 1 1 5B0E0AA9
P 8800 2200
F 0 "L1" H 8950 2050 50  0000 R CNN
F 1 "10u" H 9000 2150 50  0000 R CNN
F 2 "Inductor_SMD:L_0603_1608Metric" H 8800 2200 50  0001 C CNN
F 3 "" H 8800 2200 50  0001 C CNN
F 4 "LQM18FN100M00" H 8800 2200 60  0001 C CNN "MPN"
F 5 "Murata" H 1100 -1000 50  0001 C CNN "Manufacturer"
F 6 "490-4025-1-ND" H 1100 -1000 50  0001 C CNN "SKU"
F 7 "Digikey" H 1100 -1000 50  0001 C CNN "Supplier"
F 8 "Murata;LQM18FN100M00" H -700 -100 50  0001 C CNN "PCBA-MPN"
F 9 "Murata" H -700 -100 50  0001 C CNN "PCBA-Manufacturer"
	1    8800 2200
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR017
U 1 1 5B0E0D67
P 8950 2550
F 0 "#PWR017" H 8950 2300 50  0001 C CNN
F 1 "GND" H 9100 2450 50  0000 C CNN
F 2 "" H 8950 2550 50  0001 C CNN
F 3 "" H 8950 2550 50  0001 C CNN
	1    8950 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C2
U 1 1 5B0E0E37
P 8950 2450
F 0 "C2" H 9042 2496 50  0000 L CNN
F 1 "100n" H 9042 2405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8950 2450 50  0001 C CNN
F 3 "" H 8950 2450 50  0001 C CNN
F 4 "GRM155R61C104KA88D" H 1250 -1300 50  0001 C CNN "MPN"
F 5 "490-5415-1-ND" H 1250 -1300 50  0001 C CNN "SKU"
F 6 "Digikey" H 1250 -1300 50  0001 C CNN "Supplier"
F 7 "Murata" H 1250 -1300 50  0001 C CNN "Manufacturer"
F 8 "CC0402KRX7R8BB104" H -700 -100 50  0001 C CNN "PCBA-MPN"
F 9 "Yageo" H -700 -100 50  0001 C CNN "PCBA-Manufacturer"
	1    8950 2450
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR016
U 1 1 5B0E4DBB
P 8800 1250
F 0 "#PWR016" H 8800 1100 50  0001 C CNN
F 1 "+3.3V" H 8815 1423 50  0000 C CNN
F 2 "" H 8800 1250 50  0001 C CNN
F 3 "" H 8800 1250 50  0001 C CNN
	1    8800 1250
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5B0E4E22
P 8800 1250
F 0 "#FLG02" H 8800 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 8800 1424 50  0001 C CNN
F 2 "" H 8800 1250 50  0001 C CNN
F 3 "" H 8800 1250 50  0001 C CNN
	1    8800 1250
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG04
U 1 1 5B0E5073
P 9050 1250
F 0 "#FLG04" H 9050 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 9050 1424 50  0001 C CNN
F 2 "" H 9050 1250 50  0001 C CNN
F 3 "" H 9050 1250 50  0001 C CNN
	1    9050 1250
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5B0E524F
P 9050 1250
F 0 "#PWR018" H 9050 1000 50  0001 C CNN
F 1 "GND" H 9055 1077 50  0000 C CNN
F 2 "" H 9050 1250 50  0001 C CNN
F 3 "" H 9050 1250 50  0001 C CNN
	1    9050 1250
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR013
U 1 1 5B0E5D6C
P 8550 1250
F 0 "#PWR013" H 8550 1100 50  0001 C CNN
F 1 "+5V" H 8565 1423 50  0000 C CNN
F 2 "" H 8550 1250 50  0001 C CNN
F 3 "" H 8550 1250 50  0001 C CNN
	1    8550 1250
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5B0E5FE3
P 8550 1250
F 0 "#FLG01" H 8550 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 8550 1424 50  0001 C CNN
F 2 "" H 8550 1250 50  0001 C CNN
F 3 "" H 8550 1250 50  0001 C CNN
	1    8550 1250
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG03
U 1 1 5B0E62D8
P 8950 2350
F 0 "#FLG03" H 8950 2425 50  0001 C CNN
F 1 "PWR_FLAG" H 8950 2524 50  0001 C CNN
F 2 "" H 8950 2350 50  0001 C CNN
F 3 "" H 8950 2350 50  0001 C CNN
	1    8950 2350
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x15_Odd_Even J2
U 1 1 5B13A9E5
P 2100 5300
F 0 "J2" H 2100 6215 50  0000 C CNN
F 1 "MBUS_BOTTOM" H 2100 6124 50  0000 C CNN
F 2 "local:MBUS_Socket" H 2100 4150 50  0001 C CNN
F 3 "" H 2100 4150 50  0001 C CNN
	1    2100 5300
	1    0    0    -1  
$EndComp
Text Label 1900 4900 2    60   ~ 0
MOSI
Text Label 1900 5000 2    60   ~ 0
MISO
Text Label 1900 5100 2    60   ~ 0
SCK
Text Label 1900 5200 2    60   ~ 0
RXD0
Text Label 1900 5300 2    60   ~ 0
RXD2
Text Label 1900 5400 2    60   ~ 0
SDA
Text Label 1900 5500 2    60   ~ 0
GPIO_G2
Text Label 1900 5600 2    60   ~ 0
IIS_SK
Text Label 1900 5700 2    60   ~ 0
IIS_OUT
Text Label 1900 5800 2    60   ~ 0
HPWR
Text Label 1900 5900 2    60   ~ 0
HPWR
Text Label 1900 6000 2    60   ~ 0
HPWR
Text Label 2400 6000 0    60   ~ 0
BATTERY
Text Label 2400 5800 0    60   ~ 0
IIS_IN
Text Label 2400 5700 0    60   ~ 0
IIS_MK
Text Label 2400 5600 0    60   ~ 0
IIS_WS
Text Label 2400 5500 0    60   ~ 0
GPIO_G5
Text Label 2400 5400 0    60   ~ 0
SCL
Text Label 2400 5300 0    60   ~ 0
TXD2
Text Label 2400 5200 0    60   ~ 0
TXD0
Text Label 2400 5000 0    60   ~ 0
DAC
Text Label 2400 4900 0    60   ~ 0
DAC_SPK
Text Label 2400 4800 0    60   ~ 0
RST
Text Label 2400 4700 0    60   ~ 0
ADC_G36
Text Label 2400 4600 0    60   ~ 0
ADC_G35
$Comp
L power:GND #PWR02
U 1 1 5B13AA04
P 1650 4500
F 0 "#PWR02" H 1650 4250 50  0001 C CNN
F 1 "GND" H 1655 4327 50  0000 C CNN
F 2 "" H 1650 4500 50  0001 C CNN
F 3 "" H 1650 4500 50  0001 C CNN
	1    1650 4500
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR05
U 1 1 5B13AA0A
P 2950 5100
F 0 "#PWR05" H 2950 4950 50  0001 C CNN
F 1 "+3.3V" H 2965 5273 50  0000 C CNN
F 2 "" H 2950 5100 50  0001 C CNN
F 3 "" H 2950 5100 50  0001 C CNN
	1    2950 5100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR06
U 1 1 5B13AA10
P 2950 5900
F 0 "#PWR06" H 2950 5750 50  0001 C CNN
F 1 "+5V" H 2965 6073 50  0000 C CNN
F 2 "" H 2950 5900 50  0001 C CNN
F 3 "" H 2950 5900 50  0001 C CNN
	1    2950 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 4500 1650 4450
Wire Wire Line
	1650 4450 1850 4450
Wire Wire Line
	1850 4450 1850 4600
Wire Wire Line
	1850 4800 1900 4800
Wire Wire Line
	1900 4700 1850 4700
Connection ~ 1850 4700
Wire Wire Line
	1900 4600 1850 4600
Connection ~ 1850 4600
Wire Wire Line
	2950 5100 2400 5100
Wire Wire Line
	2950 5900 2400 5900
Wire Wire Line
	2800 4600 2400 4600
Wire Wire Line
	1900 5000 1500 5000
Wire Wire Line
	1900 5100 1500 5100
Wire Wire Line
	1900 5200 1500 5200
Wire Wire Line
	1900 5300 1500 5300
Wire Wire Line
	1900 5400 1500 5400
Wire Wire Line
	1900 5500 1500 5500
Wire Wire Line
	1900 5600 1500 5600
Wire Wire Line
	1900 5700 1500 5700
Wire Wire Line
	1900 5800 1500 5800
Wire Wire Line
	1900 5900 1500 5900
Wire Wire Line
	1900 6000 1500 6000
Wire Wire Line
	2800 4700 2400 4700
Wire Wire Line
	2800 4800 2400 4800
Wire Wire Line
	2800 4900 2400 4900
Wire Wire Line
	2800 5000 2400 5000
Wire Wire Line
	2800 5200 2400 5200
Wire Wire Line
	2800 5300 2400 5300
Wire Wire Line
	2800 5400 2400 5400
Wire Wire Line
	2800 5500 2400 5500
Wire Wire Line
	2800 5600 2400 5600
Wire Wire Line
	2800 5700 2400 5700
Wire Wire Line
	2800 5800 2400 5800
Wire Wire Line
	2800 6000 2400 6000
Wire Wire Line
	1900 4900 1500 4900
Wire Wire Line
	9300 5200 9850 5200
Text Label 9300 5200 0    60   ~ 0
BP35_CTS
Wire Wire Line
	1850 2750 1850 2850
Wire Wire Line
	1850 2650 1850 2750
Wire Wire Line
	1850 4700 1850 4800
Wire Wire Line
	1850 4600 1850 4700
$Comp
L Device:C_Small C3
U 1 1 5B27DF1D
P 9250 5950
F 0 "C3" H 9342 5996 50  0000 L CNN
F 1 "100n" H 9342 5905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9250 5950 50  0001 C CNN
F 3 "" H 9250 5950 50  0001 C CNN
F 4 "GRM155R61C104KA88D" H 350 100 50  0001 C CNN "MPN"
F 5 "490-5415-1-ND" H 350 100 50  0001 C CNN "SKU"
F 6 "Digikey" H 350 100 50  0001 C CNN "Supplier"
F 7 "Murata" H 350 100 50  0001 C CNN "Manufacturer"
F 8 "CC0402KRX7R8BB104" H -700 -100 50  0001 C CNN "PCBA-MPN"
F 9 "Yageo" H -700 -100 50  0001 C CNN "PCBA-Manufacturer"
	1    9250 5950
	-1   0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 5B27E193
P 9600 5950
F 0 "C4" H 9692 5996 50  0000 L CNN
F 1 "100n" H 9692 5905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9600 5950 50  0001 C CNN
F 3 "" H 9600 5950 50  0001 C CNN
F 4 "GRM155R61C104KA88D" H 350 100 50  0001 C CNN "MPN"
F 5 "490-5415-1-ND" H 350 100 50  0001 C CNN "SKU"
F 6 "Digikey" H 350 100 50  0001 C CNN "Supplier"
F 7 "Murata" H 350 100 50  0001 C CNN "Manufacturer"
F 8 "CC0402KRX7R8BB104" H -700 -100 50  0001 C CNN "PCBA-MPN"
F 9 "Yageo" H -700 -100 50  0001 C CNN "PCBA-Manufacturer"
	1    9600 5950
	-1   0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR019
U 1 1 5B27E1FD
P 9250 5850
F 0 "#PWR019" H 9250 5700 50  0001 C CNN
F 1 "+3.3V" H 9265 6023 50  0000 C CNN
F 2 "" H 9250 5850 50  0001 C CNN
F 3 "" H 9250 5850 50  0001 C CNN
	1    9250 5850
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR021
U 1 1 5B27E258
P 9600 5850
F 0 "#PWR021" H 9600 5700 50  0001 C CNN
F 1 "+3.3V" H 9615 6023 50  0000 C CNN
F 2 "" H 9600 5850 50  0001 C CNN
F 3 "" H 9600 5850 50  0001 C CNN
	1    9600 5850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 5B27E2B3
P 9250 6050
F 0 "#PWR020" H 9250 5800 50  0001 C CNN
F 1 "GND" H 9255 5877 50  0000 C CNN
F 2 "" H 9250 6050 50  0001 C CNN
F 3 "" H 9250 6050 50  0001 C CNN
	1    9250 6050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 5B27E30E
P 9600 6050
F 0 "#PWR022" H 9600 5800 50  0001 C CNN
F 1 "GND" H 9605 5877 50  0000 C CNN
F 2 "" H 9600 6050 50  0001 C CNN
F 3 "" H 9600 6050 50  0001 C CNN
	1    9600 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 1650 6500 1750
Wire Wire Line
	6500 1750 7200 1750
$Comp
L Connector_Generic:Conn_01x09 J3
U 1 1 5B3BC5F5
P 7400 1450
F 0 "J3" H 7477 1491 50  0000 L CNN
F 1 "AVR_IO" H 7477 1400 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x09_P2.54mm_Vertical" H 7400 1450 50  0001 C CNN
F 3 "" H 7400 1450 50  0001 C CNN
	1    7400 1450
	1    0    0    -1  
$EndComp
Text Label 6650 1450 0    60   ~ 0
AVR_PB1
NoConn ~ 9850 2900
NoConn ~ 9850 3100
NoConn ~ 9850 3500
NoConn ~ 9850 3600
Wire Wire Line
	8950 2350 8800 2350
Wire Wire Line
	8800 2350 8800 2300
Wire Wire Line
	8800 2350 8800 2600
Connection ~ 8800 2350
Wire Wire Line
	8800 2100 8800 2050
Wire Wire Line
	8800 2050 8700 2050
Wire Wire Line
	8700 2050 8700 2600
Connection ~ 8700 2050
Connection ~ 8950 2350
Wire Wire Line
	7450 2900 8100 2900
$Comp
L local:BP35A1 U1
U 1 1 5B941C3F
P 5950 4300
F 0 "U1" H 5950 5365 50  0000 C CNN
F 1 "BP35A1" H 5950 5274 50  0000 C CNN
F 2 "local:BP35A1" H 5950 4300 50  0001 C CNN
F 3 "" H 5950 4300 50  0001 C CNN
	1    5950 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5B94A85D
P 5250 5050
F 0 "#PWR08" H 5250 4800 50  0001 C CNN
F 1 "GND" H 5255 4877 50  0000 C CNN
F 2 "" H 5250 5050 50  0001 C CNN
F 3 "" H 5250 5050 50  0001 C CNN
	1    5250 5050
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR07
U 1 1 5B94A8C0
P 5250 4500
F 0 "#PWR07" H 5250 4350 50  0001 C CNN
F 1 "+3.3V" H 5265 4673 50  0000 C CNN
F 2 "" H 5250 4500 50  0001 C CNN
F 3 "" H 5250 4500 50  0001 C CNN
	1    5250 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 4500 5250 4600
Wire Wire Line
	5250 4600 5350 4600
Wire Wire Line
	5350 4500 5250 4500
Connection ~ 5250 4500
Wire Wire Line
	5350 4900 5250 4900
Wire Wire Line
	5250 4900 5250 5000
Wire Wire Line
	5350 5000 5250 5000
Connection ~ 5250 5000
Wire Wire Line
	5250 5000 5250 5050
$Comp
L power:GND #PWR010
U 1 1 5B96C75E
P 6600 5050
F 0 "#PWR010" H 6600 4800 50  0001 C CNN
F 1 "GND" H 6605 4877 50  0000 C CNN
F 2 "" H 6600 5050 50  0001 C CNN
F 3 "" H 6600 5050 50  0001 C CNN
	1    6600 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 5050 6600 5000
Wire Wire Line
	6600 4500 6550 4500
Wire Wire Line
	6550 4600 6600 4600
Connection ~ 6600 4600
Wire Wire Line
	6600 4600 6600 4500
Wire Wire Line
	6550 4700 6600 4700
Connection ~ 6600 4700
Wire Wire Line
	6600 4700 6600 4600
Wire Wire Line
	6550 4800 6600 4800
Connection ~ 6600 4800
Wire Wire Line
	6600 4800 6600 4700
Wire Wire Line
	6550 4900 6600 4900
Connection ~ 6600 4900
Wire Wire Line
	6600 4900 6600 4800
Wire Wire Line
	6550 5000 6600 5000
Connection ~ 6600 5000
Wire Wire Line
	6600 5000 6600 4900
Wire Wire Line
	6550 3900 6600 3900
Wire Wire Line
	6600 3900 6600 4500
Connection ~ 6600 4500
NoConn ~ 6550 3500
NoConn ~ 6550 3600
NoConn ~ 6550 3700
Wire Wire Line
	5350 3900 4750 3900
Text Label 4750 3900 0    50   ~ 0
BP35_TXD
Wire Wire Line
	5350 4000 4750 4000
Text Label 4750 4000 0    50   ~ 0
BP35_RXD
Text Label 4600 3650 2    50   ~ 0
BP35_TXD
$Comp
L Device:R_Small R1
U 1 1 5B9DEA06
P 3950 3450
F 0 "R1" V 4000 3600 50  0000 C CNN
F 1 "0" V 4000 3300 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3950 3450 50  0001 C CNN
F 3 "" H 3950 3450 50  0001 C CNN
F 4 "RC0402JR-07100KL" H -200 -3150 50  0001 C CNN "MPN"
F 5 "Yageo" H -200 -3150 50  0001 C CNN "Manufacturer"
F 6 "Digikey" H -200 -3150 50  0001 C CNN "Supplier"
F 7 "RC0402JR-07100KL" H -200 -3150 50  0001 C CNN "PCBA-MPN"
F 8 "Yageo" H -200 -3150 50  0001 C CNN "PCBA-Manufacturer"
	1    3950 3450
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small R3
U 1 1 5B9DEB14
P 3950 3850
F 0 "R3" V 4000 4000 50  0000 C CNN
F 1 "NMT" V 4000 3700 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3950 3850 50  0001 C CNN
F 3 "" H 3950 3850 50  0001 C CNN
F 4 "RC0402JR-07100KL" H -200 -2750 50  0001 C CNN "MPN"
F 5 "Yageo" H -200 -2750 50  0001 C CNN "Manufacturer"
F 6 "Digikey" H -200 -2750 50  0001 C CNN "Supplier"
F 7 "RC0402JR-07100KL" H -200 -2750 50  0001 C CNN "PCBA-MPN"
F 8 "Yageo" H -200 -2750 50  0001 C CNN "PCBA-Manufacturer"
	1    3950 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4600 3650 4200 3650
Wire Wire Line
	4200 3450 4050 3450
Wire Wire Line
	4050 3650 4200 3650
Wire Wire Line
	3850 3450 3250 3450
Wire Wire Line
	3850 3850 3250 3850
Text Label 3350 3450 0    50   ~ 0
GPIO_G5
Text Label 3350 3850 0    50   ~ 0
AVR_RXD0
Text Label 4600 4250 2    50   ~ 0
BP35_RXD
$Comp
L Device:R_Small R4
U 1 1 5BA1E9D7
P 3950 4050
F 0 "R4" V 4000 4200 50  0000 C CNN
F 1 "0" V 4000 3900 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3950 4050 50  0001 C CNN
F 3 "" H 3950 4050 50  0001 C CNN
F 4 "RC0402JR-07100KL" H -200 -2550 50  0001 C CNN "MPN"
F 5 "Yageo" H -200 -2550 50  0001 C CNN "Manufacturer"
F 6 "Digikey" H -200 -2550 50  0001 C CNN "Supplier"
F 7 "RC0402JR-07100KL" H -200 -2550 50  0001 C CNN "PCBA-MPN"
F 8 "Yageo" H -200 -2550 50  0001 C CNN "PCBA-Manufacturer"
	1    3950 4050
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small R5
U 1 1 5BA1E9E3
P 3950 4250
F 0 "R5" V 4000 4400 50  0000 C CNN
F 1 "NMT" V 4000 4100 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3950 4250 50  0001 C CNN
F 3 "" H 3950 4250 50  0001 C CNN
F 4 "RC0402JR-07100KL" H -200 -2350 50  0001 C CNN "MPN"
F 5 "Yageo" H -200 -2350 50  0001 C CNN "Manufacturer"
F 6 "Digikey" H -200 -2350 50  0001 C CNN "Supplier"
F 7 "RC0402JR-07100KL" H -200 -2350 50  0001 C CNN "PCBA-MPN"
F 8 "Yageo" H -200 -2350 50  0001 C CNN "PCBA-Manufacturer"
	1    3950 4250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4600 4250 4200 4250
Wire Wire Line
	4200 4050 4050 4050
Wire Wire Line
	4050 4250 4200 4250
Wire Wire Line
	3850 4050 3250 4050
Wire Wire Line
	3850 4250 3250 4250
Text Label 3350 4050 0    50   ~ 0
GPIO_G2
Text Label 3350 4250 0    50   ~ 0
IIS_SK
Wire Wire Line
	5350 3600 4750 3600
Wire Wire Line
	5350 3500 4750 3500
Text Label 4750 3500 0    50   ~ 0
BP35_WKUP
Text Label 4750 3600 0    50   ~ 0
BP35_RESET
Wire Wire Line
	5350 4100 4750 4100
Text Label 4750 4100 0    50   ~ 0
BP35_CTS
Wire Wire Line
	5350 4200 4750 4200
Text Label 4750 4200 0    50   ~ 0
BP35_RTS
Wire Wire Line
	6650 1550 7200 1550
Text Label 6650 1550 0    60   ~ 0
AVR_PD4
Wire Wire Line
	6650 1650 7200 1650
Text Label 6650 1650 0    60   ~ 0
AVR_PD5
Connection ~ 4200 3650
Wire Wire Line
	4200 3450 4200 3650
$Comp
L Device:R_Small R2
U 1 1 5BAB0A29
P 3950 3650
F 0 "R2" V 4000 3800 50  0000 C CNN
F 1 "NMT" V 4000 3500 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3950 3650 50  0001 C CNN
F 3 "" H 3950 3650 50  0001 C CNN
F 4 "RC0402JR-07100KL" H -200 -2950 50  0001 C CNN "MPN"
F 5 "Yageo" H -200 -2950 50  0001 C CNN "Manufacturer"
F 6 "Digikey" H -200 -2950 50  0001 C CNN "Supplier"
F 7 "RC0402JR-07100KL" H -200 -2950 50  0001 C CNN "PCBA-MPN"
F 8 "Yageo" H -200 -2950 50  0001 C CNN "PCBA-Manufacturer"
	1    3950 3650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3850 3650 3250 3650
Text Label 3350 3650 0    50   ~ 0
IIS_WS
Wire Wire Line
	4050 3850 4200 3850
Wire Wire Line
	4200 3850 4200 3650
Connection ~ 4200 4250
Wire Wire Line
	4200 4050 4200 4250
$Comp
L Device:R_Small R6
U 1 1 5BACE102
P 3950 4450
F 0 "R6" V 4000 4600 50  0000 C CNN
F 1 "NMT" V 4000 4300 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3950 4450 50  0001 C CNN
F 3 "" H 3950 4450 50  0001 C CNN
F 4 "RC0402JR-07100KL" H -200 -2150 50  0001 C CNN "MPN"
F 5 "Yageo" H -200 -2150 50  0001 C CNN "Manufacturer"
F 6 "Digikey" H -200 -2150 50  0001 C CNN "Supplier"
F 7 "RC0402JR-07100KL" H -200 -2150 50  0001 C CNN "PCBA-MPN"
F 8 "Yageo" H -200 -2150 50  0001 C CNN "PCBA-Manufacturer"
	1    3950 4450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3850 4450 3250 4450
Text Label 3350 4450 0    50   ~ 0
AVR_TXD0
Wire Wire Line
	4050 4450 4200 4450
Wire Wire Line
	4200 4450 4200 4250
Wire Wire Line
	1650 2550 1650 2500
Wire Wire Line
	1650 2500 1850 2500
Wire Wire Line
	1850 2500 1850 2650
Connection ~ 1850 2650
$Comp
L Mechanical:MountingHole MH4
U 1 1 5B8C50EC
P 2000 1400
F 0 "MH4" H 2100 1446 50  0000 L CNN
F 1 "Corner" H 2100 1355 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 2000 1400 50  0001 C CNN
F 3 "~" H 2000 1400 50  0001 C CNN
	1    2000 1400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH3
U 1 1 5B8C536E
P 2000 1200
F 0 "MH3" H 2100 1246 50  0000 L CNN
F 1 "Corner" H 2100 1155 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 2000 1200 50  0001 C CNN
F 3 "~" H 2000 1200 50  0001 C CNN
	1    2000 1200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH2
U 1 1 5B8C53DD
P 2000 1000
F 0 "MH2" H 2100 1046 50  0000 L CNN
F 1 "Corner" H 2100 955 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 2000 1000 50  0001 C CNN
F 3 "~" H 2000 1000 50  0001 C CNN
	1    2000 1000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH1
U 1 1 5B8C5425
P 2000 800
F 0 "MH1" H 2100 846 50  0000 L CNN
F 1 "Corner" H 2100 755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 2000 800 50  0001 C CNN
F 3 "~" H 2000 800 50  0001 C CNN
	1    2000 800 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH6
U 1 1 5B8C54F1
P 2500 1400
F 0 "MH6" H 2600 1446 50  0000 L CNN
F 1 "Fix" H 2600 1355 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.5mm" H 2500 1400 50  0001 C CNN
F 3 "~" H 2500 1400 50  0001 C CNN
	1    2500 1400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH5
U 1 1 5B8C5594
P 2500 1200
F 0 "MH5" H 2600 1246 50  0000 L CNN
F 1 "Fix" H 2600 1155 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.5mm" H 2500 1200 50  0001 C CNN
F 3 "~" H 2500 1200 50  0001 C CNN
	1    2500 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 3200 8100 3200
Text Label 7600 3200 0    60   ~ 0
AVR_ADC7
Text Label 7600 3100 0    60   ~ 0
AVR_ADC6
Wire Wire Line
	7550 3100 8100 3100
NoConn ~ 7550 3100
NoConn ~ 7550 3200
$EndSCHEMATC
