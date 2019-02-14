EESchema Schematic File Version 4
LIBS:M5Stack_WiSUN-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "M5Stack Wi-SUN Stack"
Date "2019-01-04"
Rev "Rev.C"
Comp "Kenta IDA"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_02x15_Odd_Even J2
U 1 1 5B0DA09F
P 2200 3350
F 0 "J2" H 2200 4265 50  0000 C CNN
F 1 "MBUS_TOP" H 2200 4174 50  0000 C CNN
F 2 "local:MBUS_Header" H 2200 2200 50  0001 C CNN
F 3 "" H 2200 2200 50  0001 C CNN
	1    2200 3350
	-1   0    0    -1  
$EndComp
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
L Connector_Generic:Conn_02x15_Odd_Even J1
U 1 1 5B13A9E5
P 2100 5300
F 0 "J1" H 2100 6215 50  0000 C CNN
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
GPIO_G2_R
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
GPIO_G5_R
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
	1850 2750 1850 2850
Wire Wire Line
	1850 2650 1850 2750
Wire Wire Line
	1850 4700 1850 4800
Wire Wire Line
	1850 4600 1850 4700
$Comp
L power:GND #PWR08
U 1 1 5B94A85D
P 4000 5100
F 0 "#PWR08" H 4000 4850 50  0001 C CNN
F 1 "GND" H 4005 4927 50  0000 C CNN
F 2 "" H 4000 5100 50  0001 C CNN
F 3 "" H 4000 5100 50  0001 C CNN
	1    4000 5100
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR07
U 1 1 5B94A8C0
P 4000 4550
F 0 "#PWR07" H 4000 4400 50  0001 C CNN
F 1 "+3.3V" H 4015 4723 50  0000 C CNN
F 2 "" H 4000 4550 50  0001 C CNN
F 3 "" H 4000 4550 50  0001 C CNN
	1    4000 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 4550 4000 4650
Wire Wire Line
	4000 4650 4100 4650
Wire Wire Line
	4100 4550 4000 4550
Connection ~ 4000 4550
Wire Wire Line
	4100 4950 4000 4950
Wire Wire Line
	4000 4950 4000 5050
Wire Wire Line
	4100 5050 4000 5050
Connection ~ 4000 5050
Wire Wire Line
	4000 5050 4000 5100
$Comp
L power:GND #PWR012
U 1 1 5B96C75E
P 5350 5100
F 0 "#PWR012" H 5350 4850 50  0001 C CNN
F 1 "GND" H 5355 4927 50  0000 C CNN
F 2 "" H 5350 5100 50  0001 C CNN
F 3 "" H 5350 5100 50  0001 C CNN
	1    5350 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 5100 5350 5050
Wire Wire Line
	5350 4550 5300 4550
Wire Wire Line
	5300 4650 5350 4650
Connection ~ 5350 4650
Wire Wire Line
	5350 4650 5350 4550
Wire Wire Line
	5300 4750 5350 4750
Connection ~ 5350 4750
Wire Wire Line
	5350 4750 5350 4650
Wire Wire Line
	5300 4850 5350 4850
Connection ~ 5350 4850
Wire Wire Line
	5350 4850 5350 4750
Wire Wire Line
	5300 4950 5350 4950
Connection ~ 5350 4950
Wire Wire Line
	5350 4950 5350 4850
Wire Wire Line
	5300 5050 5350 5050
Connection ~ 5350 5050
Wire Wire Line
	5350 5050 5350 4950
Wire Wire Line
	5300 3950 5350 3950
Wire Wire Line
	5350 3950 5350 4550
Connection ~ 5350 4550
NoConn ~ 5300 3550
NoConn ~ 5300 3650
NoConn ~ 5300 3750
Wire Wire Line
	4100 3950 3500 3950
Wire Wire Line
	4100 4050 3500 4050
Wire Wire Line
	4100 3650 3500 3650
Wire Wire Line
	4100 3550 3500 3550
Text Label 3500 3550 0    50   ~ 0
BP35_WKUP
Text Label 3500 3650 0    50   ~ 0
BP35_RESET
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
F 2 "MountingHole:MountingHole_3.2mm_M3" H 2000 1400 50  0001 C CNN
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
F 2 "MountingHole:MountingHole_3.2mm_M3" H 2000 1200 50  0001 C CNN
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
F 2 "MountingHole:MountingHole_3.2mm_M3" H 2000 1000 50  0001 C CNN
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
F 2 "MountingHole:MountingHole_3.2mm_M3" H 2000 800 50  0001 C CNN
F 3 "~" H 2000 800 50  0001 C CNN
	1    2000 800 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH6
U 1 1 5B8C54F1
P 2500 1000
F 0 "MH6" H 2600 1046 50  0000 L CNN
F 1 "Fix" H 2600 955 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 2500 1000 50  0001 C CNN
F 3 "~" H 2500 1000 50  0001 C CNN
	1    2500 1000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH5
U 1 1 5B8C5594
P 2500 800
F 0 "MH5" H 2600 846 50  0000 L CNN
F 1 "Fix" H 2600 755 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 2500 800 50  0001 C CNN
F 3 "~" H 2500 800 50  0001 C CNN
	1    2500 800 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH7
U 1 1 5BC59567
P 2500 1200
F 0 "MH7" H 2600 1246 50  0000 L CNN
F 1 "Fix" H 2600 1155 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 2500 1200 50  0001 C CNN
F 3 "~" H 2500 1200 50  0001 C CNN
	1    2500 1200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole MH8
U 1 1 5BC595BB
P 2500 1400
F 0 "MH8" H 2600 1446 50  0000 L CNN
F 1 "Fix" H 2600 1355 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 2500 1400 50  0001 C CNN
F 3 "~" H 2500 1400 50  0001 C CNN
	1    2500 1400
	1    0    0    -1  
$EndComp
Text Label 3800 4050 2    50   ~ 0
GPIO_G5
Text Label 3800 3950 2    50   ~ 0
GPIO_G2
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5BD62077
P 4450 1150
F 0 "#FLG01" H 4450 1225 50  0001 C CNN
F 1 "PWR_FLAG" H 4450 1324 50  0001 C CNN
F 2 "" H 4450 1150 50  0001 C CNN
F 3 "~" H 4450 1150 50  0001 C CNN
	1    4450 1150
	-1   0    0    1   
$EndComp
$Comp
L power:+3.3V #PWR09
U 1 1 5BD6210A
P 4450 1150
F 0 "#PWR09" H 4450 1000 50  0001 C CNN
F 1 "+3.3V" H 4465 1323 50  0000 C CNN
F 2 "" H 4450 1150 50  0001 C CNN
F 3 "" H 4450 1150 50  0001 C CNN
	1    4450 1150
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5BD6D280
P 4650 1150
F 0 "#FLG02" H 4650 1225 50  0001 C CNN
F 1 "PWR_FLAG" H 4650 1324 50  0001 C CNN
F 2 "" H 4650 1150 50  0001 C CNN
F 3 "~" H 4650 1150 50  0001 C CNN
	1    4650 1150
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR010
U 1 1 5BD6D2C9
P 4650 1150
F 0 "#PWR010" H 4650 1000 50  0001 C CNN
F 1 "+5V" H 4665 1323 50  0000 C CNN
F 2 "" H 4650 1150 50  0001 C CNN
F 3 "" H 4650 1150 50  0001 C CNN
	1    4650 1150
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG03
U 1 1 5BD6D312
P 4850 1150
F 0 "#FLG03" H 4850 1225 50  0001 C CNN
F 1 "PWR_FLAG" H 4850 1324 50  0001 C CNN
F 2 "" H 4850 1150 50  0001 C CNN
F 3 "~" H 4850 1150 50  0001 C CNN
	1    4850 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 5BD6D399
P 4850 1150
F 0 "#PWR011" H 4850 900 50  0001 C CNN
F 1 "GND" H 4855 977 50  0000 C CNN
F 2 "" H 4850 1150 50  0001 C CNN
F 3 "" H 4850 1150 50  0001 C CNN
	1    4850 1150
	1    0    0    -1  
$EndComp
$Comp
L local:BP35A1 U1
U 1 1 5B941C3F
P 4700 4350
F 0 "U1" H 4700 5415 50  0000 C CNN
F 1 "BP35A1" H 4700 5324 50  0000 C CNN
F 2 "local:BP35A1" H 4700 4350 50  0001 C CNN
F 3 "" H 4700 4350 50  0001 C CNN
	1    4700 4350
	1    0    0    -1  
$EndComp
$Comp
L local:PCA9557 U2
U 1 1 5C2FA6A7
P 7350 4000
F 0 "U2" H 7350 4675 50  0000 C CNN
F 1 "PCA9557" H 7350 4584 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 7350 3950 50  0001 C CNN
F 3 "" H 7350 3950 50  0001 C CNN
	1    7350 4000
	1    0    0    -1  
$EndComp
Text Label 6900 3750 2    50   ~ 0
A0
Wire Wire Line
	6950 3750 6800 3750
Text Label 6900 3850 2    50   ~ 0
A1
Wire Wire Line
	6950 3850 6800 3850
Text Label 6900 3950 2    50   ~ 0
A2
Wire Wire Line
	6950 3950 6800 3950
$Comp
L Device:R_Small R2
U 1 1 5C37F74C
P 6650 5150
F 0 "R2" H 6709 5196 50  0000 L CNN
F 1 "2k" H 6709 5105 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 6650 5150 50  0001 C CNN
F 3 "~" H 6650 5150 50  0001 C CNN
	1    6650 5150
	1    0    0    -1  
$EndComp
Text Label 6450 5600 0    50   ~ 0
A0
Text Label 6850 5600 0    50   ~ 0
A1
$Comp
L power:+3.3V #PWR016
U 1 1 5C38B7F6
P 6650 5050
F 0 "#PWR016" H 6650 4900 50  0001 C CNN
F 1 "+3.3V" H 6665 5223 50  0000 C CNN
F 2 "" H 6650 5050 50  0001 C CNN
F 3 "" H 6650 5050 50  0001 C CNN
	1    6650 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R3
U 1 1 5C3981C1
P 6700 4150
F 0 "R3" V 6504 4150 50  0000 C CNN
F 1 "2k" V 6595 4150 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 6700 4150 50  0001 C CNN
F 3 "~" H 6700 4150 50  0001 C CNN
	1    6700 4150
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR014
U 1 1 5C398225
P 6450 4150
F 0 "#PWR014" H 6450 4000 50  0001 C CNN
F 1 "+3.3V" H 6465 4323 50  0000 C CNN
F 2 "" H 6450 4150 50  0001 C CNN
F 3 "" H 6450 4150 50  0001 C CNN
	1    6450 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 4150 6600 4150
Wire Wire Line
	6800 4150 6950 4150
Wire Wire Line
	6950 4300 6450 4300
Wire Wire Line
	6450 4300 6450 4150
Connection ~ 6450 4150
$Comp
L Device:C_Small C1
U 1 1 5C3AB855
P 6450 4400
F 0 "C1" H 6542 4446 50  0000 L CNN
F 1 "100n" H 6542 4355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6450 4400 50  0001 C CNN
F 3 "~" H 6450 4400 50  0001 C CNN
	1    6450 4400
	1    0    0    -1  
$EndComp
Connection ~ 6450 4300
$Comp
L power:GND #PWR015
U 1 1 5C3AB8DF
P 6450 4500
F 0 "#PWR015" H 6450 4250 50  0001 C CNN
F 1 "GND" H 6455 4327 50  0000 C CNN
F 2 "" H 6450 4500 50  0001 C CNN
F 3 "" H 6450 4500 50  0001 C CNN
	1    6450 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR019
U 1 1 5C3AB91A
P 6900 4500
F 0 "#PWR019" H 6900 4250 50  0001 C CNN
F 1 "GND" H 6905 4327 50  0000 C CNN
F 2 "" H 6900 4500 50  0001 C CNN
F 3 "" H 6900 4500 50  0001 C CNN
	1    6900 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 4500 6900 4450
Wire Wire Line
	6900 4450 6950 4450
Wire Wire Line
	6950 3650 6800 3650
Wire Wire Line
	6250 3550 6600 3550
Text Label 6450 3650 2    50   ~ 0
SDA
Text Label 6450 3550 2    50   ~ 0
SCL
$Comp
L Device:R_Small R1
U 1 1 5C3C6E1A
P 6600 3350
F 0 "R1" H 6659 3396 50  0000 L CNN
F 1 "2k" H 6659 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 6600 3350 50  0001 C CNN
F 3 "~" H 6600 3350 50  0001 C CNN
	1    6600 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R4
U 1 1 5C3C6E90
P 6800 3350
F 0 "R4" H 6859 3396 50  0000 L CNN
F 1 "2k" H 6859 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 6800 3350 50  0001 C CNN
F 3 "~" H 6800 3350 50  0001 C CNN
	1    6800 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 3450 6600 3550
Connection ~ 6600 3550
Wire Wire Line
	6600 3550 6950 3550
Wire Wire Line
	6800 3450 6800 3650
Connection ~ 6800 3650
Wire Wire Line
	6800 3650 6250 3650
$Comp
L power:+3.3V #PWR018
U 1 1 5C3D4D45
P 6700 3200
F 0 "#PWR018" H 6700 3050 50  0001 C CNN
F 1 "+3.3V" H 6715 3373 50  0000 C CNN
F 2 "" H 6700 3200 50  0001 C CNN
F 3 "" H 6700 3200 50  0001 C CNN
	1    6700 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6700 3200 6600 3200
Wire Wire Line
	6600 3200 6600 3250
Wire Wire Line
	6700 3200 6800 3200
Wire Wire Line
	6800 3200 6800 3250
Connection ~ 6700 3200
NoConn ~ 4100 4150
NoConn ~ 4100 4250
Text Label 7850 4350 0    50   ~ 0
BP35_WKUP
Text Label 7850 4250 0    50   ~ 0
BP35_RESET
Text Label 7850 4150 0    50   ~ 0
GPIO_G2_R
Text Label 7850 4050 0    50   ~ 0
GPIO_G5_R
$Comp
L Device:R_Small R5
U 1 1 5C4530CA
P 8350 3400
F 0 "R5" V 8300 3150 50  0000 L CNN
F 1 "100k" V 8300 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 8350 3400 50  0001 C CNN
F 3 "~" H 8350 3400 50  0001 C CNN
	1    8350 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R6
U 1 1 5C453764
P 8450 3400
F 0 "R6" V 8400 3150 50  0000 L CNN
F 1 "100k" V 8400 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 8450 3400 50  0001 C CNN
F 3 "~" H 8450 3400 50  0001 C CNN
	1    8450 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R7
U 1 1 5C4537A4
P 8550 3400
F 0 "R7" V 8500 3150 50  0000 L CNN
F 1 "100k" V 8500 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 8550 3400 50  0001 C CNN
F 3 "~" H 8550 3400 50  0001 C CNN
	1    8550 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R8
U 1 1 5C4537EA
P 8650 3400
F 0 "R8" V 8600 3150 50  0000 L CNN
F 1 "100k" V 8600 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 8650 3400 50  0001 C CNN
F 3 "~" H 8650 3400 50  0001 C CNN
	1    8650 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R9
U 1 1 5C45382E
P 8750 3400
F 0 "R9" V 8700 3150 50  0000 L CNN
F 1 "100k" V 8700 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 8750 3400 50  0001 C CNN
F 3 "~" H 8750 3400 50  0001 C CNN
	1    8750 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R10
U 1 1 5C453874
P 8850 3400
F 0 "R10" V 8800 3150 50  0000 L CNN
F 1 "100k" V 8800 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 8850 3400 50  0001 C CNN
F 3 "~" H 8850 3400 50  0001 C CNN
	1    8850 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R11
U 1 1 5C4538C0
P 8950 3400
F 0 "R11" V 8900 3150 50  0000 L CNN
F 1 "100k" V 8900 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 8950 3400 50  0001 C CNN
F 3 "~" H 8950 3400 50  0001 C CNN
	1    8950 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R12
U 1 1 5C45390A
P 9050 3400
F 0 "R12" V 9000 3150 50  0000 L CNN
F 1 "100k" V 9000 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 9050 3400 50  0001 C CNN
F 3 "~" H 9050 3400 50  0001 C CNN
	1    9050 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 3500 8350 3650
Wire Wire Line
	7750 3650 8350 3650
Wire Wire Line
	8450 3500 8450 3750
Wire Wire Line
	7750 3750 8450 3750
Wire Wire Line
	8550 3850 8550 3500
Wire Wire Line
	7750 3850 8550 3850
Wire Wire Line
	8650 3500 8650 3950
Wire Wire Line
	7750 3950 8650 3950
Wire Wire Line
	8750 4050 8750 3500
Wire Wire Line
	7750 4050 8750 4050
Wire Wire Line
	8850 4150 8850 3500
Wire Wire Line
	7750 4150 8850 4150
Wire Wire Line
	8950 4250 8950 3500
Wire Wire Line
	7750 4250 8950 4250
Wire Wire Line
	9050 4350 9050 3500
Wire Wire Line
	7750 4350 9050 4350
Wire Wire Line
	8350 3300 8350 3100
Wire Wire Line
	8450 3300 8450 3100
Wire Wire Line
	8550 3300 8550 3100
Wire Wire Line
	8650 3100 8650 3300
Wire Wire Line
	8750 3300 8750 3100
Wire Wire Line
	8850 3100 8850 3300
Wire Wire Line
	8950 3300 8950 3100
Wire Wire Line
	9050 3100 9050 3300
Wire Wire Line
	8350 3100 8450 3100
Wire Wire Line
	8450 3100 8550 3100
Connection ~ 8450 3100
Wire Wire Line
	8750 3100 8700 3100
Wire Wire Line
	8650 3100 8550 3100
Connection ~ 8650 3100
Connection ~ 8550 3100
Wire Wire Line
	8750 3100 8850 3100
Connection ~ 8750 3100
Wire Wire Line
	8850 3100 8950 3100
Connection ~ 8850 3100
Wire Wire Line
	8950 3100 9050 3100
Connection ~ 8950 3100
Wire Wire Line
	8700 3100 8700 3050
Connection ~ 8700 3100
Wire Wire Line
	8700 3100 8650 3100
$Comp
L power:+3.3V #PWR021
U 1 1 5C4D35F0
P 8700 3050
F 0 "#PWR021" H 8700 2900 50  0001 C CNN
F 1 "+3.3V" H 8715 3223 50  0000 C CNN
F 2 "" H 8700 3050 50  0001 C CNN
F 3 "" H 8700 3050 50  0001 C CNN
	1    8700 3050
	1    0    0    -1  
$EndComp
Text Label 7850 3650 0    50   ~ 0
EXT3
Text Label 7850 3750 0    50   ~ 0
EXT2
Text Label 7850 3850 0    50   ~ 0
EXT1
Text Label 7850 3950 0    50   ~ 0
EXT0
$Comp
L Connector:TestPoint TP1
U 1 1 5C4D9A30
P 9800 3650
F 0 "TP1" V 9800 3850 50  0000 L CNN
F 1 "TestPoint" H 9858 3679 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 10000 3650 50  0001 C CNN
F 3 "~" H 10000 3650 50  0001 C CNN
	1    9800 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 3650 9800 3650
Wire Wire Line
	9200 3750 9900 3750
Wire Wire Line
	9200 3850 10000 3850
Wire Wire Line
	9200 3950 10100 3950
Text Label 9300 3650 0    50   ~ 0
EXT3
Text Label 9300 3750 0    50   ~ 0
EXT2
Text Label 9300 3850 0    50   ~ 0
EXT1
Text Label 9300 3950 0    50   ~ 0
EXT0
$Comp
L Connector:TestPoint TP2
U 1 1 5C4E00E7
P 9900 3650
F 0 "TP2" V 9900 3850 50  0000 L CNN
F 1 "TestPoint" H 9958 3679 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 10100 3650 50  0001 C CNN
F 3 "~" H 10100 3650 50  0001 C CNN
	1    9900 3650
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP3
U 1 1 5C4E029D
P 10000 3650
F 0 "TP3" V 10000 3850 50  0000 L CNN
F 1 "TestPoint" H 10058 3679 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 10200 3650 50  0001 C CNN
F 3 "~" H 10200 3650 50  0001 C CNN
	1    10000 3650
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP4
U 1 1 5C4E02EF
P 10100 3650
F 0 "TP4" V 10100 3850 50  0000 L CNN
F 1 "TestPoint" H 10158 3679 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 10300 3650 50  0001 C CNN
F 3 "~" H 10300 3650 50  0001 C CNN
	1    10100 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 3650 9900 3750
Wire Wire Line
	10000 3650 10000 3850
Wire Wire Line
	10100 3650 10100 3950
$Comp
L Connector:TestPoint TP5
U 1 1 5C4FA40E
P 10200 3650
F 0 "TP5" V 10200 3850 50  0000 L CNN
F 1 "TestPoint" H 10258 3679 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 10400 3650 50  0001 C CNN
F 3 "~" H 10400 3650 50  0001 C CNN
	1    10200 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 5C4FA4AF
P 10400 3800
F 0 "#PWR023" H 10400 3550 50  0001 C CNN
F 1 "GND" H 10405 3627 50  0000 C CNN
F 2 "" H 10400 3800 50  0001 C CNN
F 3 "" H 10400 3800 50  0001 C CNN
	1    10400 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP6
U 1 1 5C4FA569
P 10400 3650
F 0 "TP6" V 10400 3850 50  0000 L CNN
F 1 "TestPoint" H 10458 3679 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 10600 3650 50  0001 C CNN
F 3 "~" H 10600 3650 50  0001 C CNN
	1    10400 3650
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR022
U 1 1 5C500987
P 10300 3300
F 0 "#PWR022" H 10300 3150 50  0001 C CNN
F 1 "+3.3V" H 10315 3473 50  0000 C CNN
F 2 "" H 10300 3300 50  0001 C CNN
F 3 "" H 10300 3300 50  0001 C CNN
	1    10300 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	10400 3650 10400 3800
Wire Wire Line
	10200 3650 10300 3650
Wire Wire Line
	10300 3650 10300 3300
Wire Wire Line
	6400 5600 6550 5600
$Comp
L Jumper:Jumper_3_Bridged12 JP1
U 1 1 5C543CCB
P 6250 5600
F 0 "JP1" V 6300 5450 50  0000 L CNN
F 1 "Jumper_3_Bridged12" V 6205 5666 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged12_Pad1.0x1.5mm" H 6250 5600 50  0001 C CNN
F 3 "~" H 6250 5600 50  0001 C CNN
	1    6250 5600
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:Jumper_3_Bridged12 JP2
U 1 1 5C55C7E7
P 6650 5600
F 0 "JP2" V 6700 5450 50  0000 L CNN
F 1 "Jumper_3_Bridged12" V 6605 5666 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged12_Pad1.0x1.5mm" H 6650 5600 50  0001 C CNN
F 3 "~" H 6650 5600 50  0001 C CNN
	1    6650 5600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6800 5600 6950 5600
$Comp
L Jumper:Jumper_3_Bridged12 JP3
U 1 1 5C56F3D8
P 7050 5600
F 0 "JP3" V 7100 5450 50  0000 L CNN
F 1 "Jumper_3_Bridged12" V 7005 5666 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged12_Pad1.0x1.5mm" H 7050 5600 50  0001 C CNN
F 3 "~" H 7050 5600 50  0001 C CNN
	1    7050 5600
	0    -1   -1   0   
$EndComp
Text Label 7250 5600 0    50   ~ 0
A2
Wire Wire Line
	7200 5600 7350 5600
$Comp
L power:GND #PWR013
U 1 1 5C588046
P 6250 5850
F 0 "#PWR013" H 6250 5600 50  0001 C CNN
F 1 "GND" H 6255 5677 50  0000 C CNN
F 2 "" H 6250 5850 50  0001 C CNN
F 3 "" H 6250 5850 50  0001 C CNN
	1    6250 5850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 5C588099
P 6650 5850
F 0 "#PWR017" H 6650 5600 50  0001 C CNN
F 1 "GND" H 6655 5677 50  0000 C CNN
F 2 "" H 6650 5850 50  0001 C CNN
F 3 "" H 6650 5850 50  0001 C CNN
	1    6650 5850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 5C5880EC
P 7050 5850
F 0 "#PWR020" H 7050 5600 50  0001 C CNN
F 1 "GND" H 7055 5677 50  0000 C CNN
F 2 "" H 7050 5850 50  0001 C CNN
F 3 "" H 7050 5850 50  0001 C CNN
	1    7050 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 5350 6250 5250
Wire Wire Line
	6250 5250 6650 5250
Wire Wire Line
	7050 5350 7050 5250
Wire Wire Line
	7050 5250 6650 5250
Connection ~ 6650 5250
Wire Wire Line
	6650 5350 6650 5250
$EndSCHEMATC
