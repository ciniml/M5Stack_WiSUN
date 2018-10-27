EESchema Schematic File Version 4
LIBS:M5Stack_WiSUN-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "M5Stack Wi-SUN Stack"
Date "2018-09-01"
Rev "Rev.B"
Comp "Kenta IDA"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
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
	1850 2750 1850 2850
Wire Wire Line
	1850 2650 1850 2750
Wire Wire Line
	1850 4700 1850 4800
Wire Wire Line
	1850 4600 1850 4700
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
Text Label 3500 3950 0    50   ~ 0
BP35_TXD
Wire Wire Line
	4100 4050 3500 4050
Text Label 3500 4050 0    50   ~ 0
BP35_RXD
Wire Wire Line
	4100 3650 3500 3650
Wire Wire Line
	4100 3550 3500 3550
Text Label 3500 3550 0    50   ~ 0
BP35_WKUP
Text Label 3500 3650 0    50   ~ 0
BP35_RESET
Wire Wire Line
	4100 4150 3500 4150
Text Label 3500 4150 0    50   ~ 0
BP35_CTS
Wire Wire Line
	4100 4250 3500 4250
Text Label 3500 4250 0    50   ~ 0
BP35_RTS
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
P 2500 1000
F 0 "MH6" H 2600 1046 50  0000 L CNN
F 1 "Fix" H 2600 955 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.5mm_Pad" H 2500 1000 50  0001 C CNN
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
F 2 "MountingHole:MountingHole_2.5mm_Pad" H 2500 800 50  0001 C CNN
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
F 2 "MountingHole:MountingHole_2.5mm_Pad" H 2500 1200 50  0001 C CNN
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
F 2 "MountingHole:MountingHole_2.5mm_Pad" H 2500 1400 50  0001 C CNN
F 3 "~" H 2500 1400 50  0001 C CNN
	1    2500 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 3100 5750 3100
Text Label 5750 3100 0    50   ~ 0
BP35_TXD
Wire Wire Line
	6350 3850 5750 3850
Text Label 5750 3850 0    50   ~ 0
BP35_RXD
Wire Wire Line
	6350 4600 5750 4600
Text Label 5750 4800 0    50   ~ 0
BP35_CTS
Wire Wire Line
	6350 4800 5750 4800
Text Label 5750 4600 0    50   ~ 0
BP35_RTS
Wire Wire Line
	6350 2550 5750 2550
Wire Wire Line
	6350 2350 5750 2350
Text Label 5750 2550 0    50   ~ 0
BP35_WKUP
Text Label 5750 2350 0    50   ~ 0
BP35_RESET
Wire Wire Line
	6350 2450 6350 2350
Wire Wire Line
	6350 2650 6350 2550
Wire Wire Line
	7550 3950 6950 3950
Text Label 7250 3950 0    50   ~ 0
GPIO_G5
Wire Wire Line
	7550 3200 6950 3200
Text Label 7250 3200 0    50   ~ 0
GPIO_G2
Wire Wire Line
	7550 3300 6950 3300
Text Label 7300 3300 0    50   ~ 0
IIS_SK
Wire Wire Line
	7550 4050 6950 4050
Text Label 7300 4050 0    50   ~ 0
IIS_WS
Wire Wire Line
	7550 3100 6950 3100
Text Label 7350 3100 0    50   ~ 0
RXD2
Wire Wire Line
	7550 3850 6950 3850
Text Label 7350 3850 0    50   ~ 0
TXD2
Wire Wire Line
	7550 2550 6950 2550
Text Label 7250 2550 0    50   ~ 0
GPIO_G2
Wire Wire Line
	7550 2650 6950 2650
Text Label 7300 2650 0    50   ~ 0
IIS_SK
Wire Wire Line
	7550 2350 6950 2350
Text Label 7250 2350 0    50   ~ 0
GPIO_G5
Wire Wire Line
	7550 2450 6950 2450
Text Label 7300 2450 0    50   ~ 0
IIS_WS
Wire Wire Line
	7550 4800 6950 4800
Text Label 7300 4800 0    50   ~ 0
IIS_SK
Wire Wire Line
	7550 4900 6950 4900
Text Label 7300 4900 0    50   ~ 0
IIS_OUT
Wire Wire Line
	7550 4600 6950 4600
Text Label 7300 4600 0    50   ~ 0
IIS_WS
Wire Wire Line
	7550 4700 6950 4700
Text Label 7300 4700 0    50   ~ 0
IIS_MK
Wire Wire Line
	6350 4700 6350 4600
Wire Wire Line
	6350 4900 6350 4800
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
Wire Wire Line
	5550 3500 4950 3500
Text Label 4950 3500 0    50   ~ 0
BP35_CTS
Wire Wire Line
	5550 3700 4950 3700
Text Label 4950 3700 0    50   ~ 0
BP35_RTS
$Comp
L Connector_Generic:Conn_02x04_Odd_Even J3
U 1 1 5BE17F82
P 6650 2450
F 0 "J3" H 6700 2767 50  0000 C CNN
F 1 "PH127-2x4MG" H 6700 2676 50  0000 C CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_2x04_P1.27mm_Vertical_SMD" H 6650 2450 50  0001 C CNN
F 3 "~" H 6650 2450 50  0001 C CNN
	1    6650 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 3100 6350 3200
Wire Wire Line
	6350 3850 6350 3950
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J4
U 1 1 5BE1816F
P 6650 3200
F 0 "J4" H 6700 3517 50  0000 C CNN
F 1 "PH127-2x3MG" H 6700 3426 50  0000 C CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_2x03_P1.27mm_Vertical_SMD" H 6650 3200 50  0001 C CNN
F 3 "~" H 6650 3200 50  0001 C CNN
	1    6650 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 2350 6450 2350
Connection ~ 6350 2350
Wire Wire Line
	6450 2450 6350 2450
Wire Wire Line
	6350 2550 6450 2550
Connection ~ 6350 2550
Wire Wire Line
	6450 2650 6350 2650
Wire Wire Line
	6450 3100 6350 3100
Connection ~ 6350 3100
Wire Wire Line
	6450 3200 6350 3200
Connection ~ 6350 3200
Wire Wire Line
	6350 3200 6350 3300
Wire Wire Line
	6450 3300 6350 3300
Wire Wire Line
	6450 3850 6350 3850
Connection ~ 6350 3850
Wire Wire Line
	6450 3950 6350 3950
Connection ~ 6350 3950
Wire Wire Line
	6350 3950 6350 4050
Wire Wire Line
	6450 4050 6350 4050
Wire Wire Line
	6350 4600 6450 4600
Connection ~ 6350 4600
Wire Wire Line
	6450 4700 6350 4700
Wire Wire Line
	6350 4800 6450 4800
Connection ~ 6350 4800
Wire Wire Line
	6450 4900 6350 4900
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J5
U 1 1 5BE8797A
P 6650 3950
F 0 "J5" H 6700 4267 50  0000 C CNN
F 1 "PH127-2x3MG" H 6700 4176 50  0000 C CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_2x03_P1.27mm_Vertical_SMD" H 6650 3950 50  0001 C CNN
F 3 "~" H 6650 3950 50  0001 C CNN
	1    6650 3950
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x04_Odd_Even J6
U 1 1 5BE87A1E
P 6650 4700
F 0 "J6" H 6700 5017 50  0000 C CNN
F 1 "PH127-2x4MG" H 6700 4926 50  0000 C CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_2x04_P1.27mm_Vertical_SMD" H 6650 4700 50  0001 C CNN
F 3 "~" H 6650 4700 50  0001 C CNN
	1    6650 4700
	1    0    0    -1  
$EndComp
$EndSCHEMATC
