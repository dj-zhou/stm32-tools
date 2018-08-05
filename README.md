# STM32F4  Development, Tools

## 1. st-link v2

The new version of st-link v2 from GitHub at this **[page](https://github.com/texane/stlink)**. Run the following code in its root folder.

	$ sudo apt-get install libusb-1.0.0-dev
	$ unzip stlink-master.zip
    $ cd stlink-master/
	$ make release
    $ cd build/Release/
    $ sudo make install
    $ sudo cp /usr/local/bin/st* ../

If in the download section as below, you see the error like this:

	st-flash: error while loading shared libraries: libstlink-shared.so.1: cannot open shared object file: No such file or directory

You should run the following command:

	$ sudo ldconfig


The stlink uses the SWD port, as well as the serial port to program the STM32 chip. The SWD port uses a few pins from the JTAG port.

A standard SWD port use the following pins:


      | 1. VDD_TARGET  |
      | 2. SWCLK       |
      | 3. GND         |
      | 4. SWDIO       |
      | 5. NRST        |
      | 6. SWO         |
      however, only pin 1 to pin 4 are necessary.

The standard JTAG port is as following:


     |  1. 3.3V                     |  2. 3.3V |
     |  3. PB4/TRST                 |  4. GND  |
     |  5. PA15/TDI                 |  6. GND  |
     |  7. PA13/TMS (PA13 is SWDIO) |  8. GND  |
     |  9. PA14/TCK (PA14 is SWCLK) | 10. GND  |
	 | 11. ??                       | 12. GND  |
     | 13. PB3/TDO                  | 14. GND  |
     | 15. RST                      | 16. GND  |
     | 17. ??                       | 18. GND  |
     | 19. ??                       | 20. GND  |

Write a program to stm32 flash:

	$ st-flash write file.bin 0x8000000

Erase stm32 flash:

	$ st-flash erase

The above commands are intergrated into the Makefile.

## 2. stm32flash
	By using this tool, the STM32 chip can be programmed with USB-UART device, do thw following

	$ cd stm32flash/
	$ make 
Before using stm32flash, you need to know a few fact. Three USART ports (not sure if others can or not) can be used to programming the STM32F4 chip by stm32flash, the three ports are:

	1. TX: PA9 ; RX: PA10 (USART1)
	2. TX: PB10; RX: PB11 (USART3, available on STM32F4DISCOVERY BOARD)
	3. TX: PC10; RX: PC11 (USART3, available on STM32F4DISCOVERY BOARD)

You need also set BOOT0 = HIGHT, and BOOT1(PB2) = LOW, BEFORE POWERING ON the board, to flash the chip.

About the BOOT0, BOOT1 (PB2) pins:

	|  BOOT1  |   BOOT0  |   Boot Mode                                                                    |
	|    x    |     0    |   main Flash memory (ROM)                                                      |
	|    0    |     1    |   System memory (bootloader, can be used to upload firmware by serial port)    |
	|    1    |     1    |   Embedded SRAM, for debugging(J-link, for example)                            |



Flash with verify and then start execution by the following command:

	$ stm32flash -w filename.bin -v -g 0x0 /dev/ttyUSB0

Notice that it takes much longer time than the stlink tool to flash the STM32 chip.

Get device information:

	$ stm32flash /dev/ttyUSB0

Read stm32 flash to a file:

	$ stm32flash -r filename /dev/ttyUSB0

Erase stm32 flash:

	$ st-flash erase

Start execution:

	$ stm32flash -g 0x0 /dev/ttyUSB0

The above commands are intergrated into the Makefile.



