# Write Chip ATMEGA 328p
This is script was built to compile and burn programs into atmega328p with a single command only specifying the path to the files.

After clonning, my sugestion is that you move the file to your project folder and execute the commands:
```
chmod a+x
```
To make the file executable (Mandatory for Mac users)

and
```
./write_chip.sh -n main.c,ATmega328.c,spi.c -g
```
Being -n the parameter to specify the path to the files and -g the flag to specify that you want the burning process as well.

To use this script you must have well set on your computer:

avr-gcc
avrdude


Used and tested on ubuntu 18.04.

If you want to contribute or have any doubts about the script please let me know.
