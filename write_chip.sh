#!/bin/bash

die() {
	echo "$*" 1>&2
	exit 1
}

file_provided="0"
while getopts ":n:g" opt; do
	case $opt in
	n)
		IFS=','
		i=0
		erro=0
		args=$OPTARG
		for arg in $args; do
			if [ ${arg##*.} != "c" ] && [ ${arg##*.} != "cpp" ]; then
				erro=1
			fi
		done

		if [ $erro = 0 ]; then
			echo "Build started"
			avr-gcc -g -Os -mmcu=atmega328p -c $OPTARG
			args2=()
			for arg in $args; do
				args2+=("${arg%.*}"".o")
			done

			avr-gcc -mmcu=atmega328p "${args2[@]}" -o proj.elf
			avr-objcopy -O ihex -j .text -j .data proj.elf proj.hex

			file_provided="proj.hex"
			echo "Build finished"
		else
			die 'ERROR: "-n" requires .c or .cpp file(s)'
		fi
		;;
	g)
		if [ $file_provided != "0" ]; then
			echo "Burning started"
			sudo chmod a+rw /dev/ttyACM0
			avrdude -P /dev/ttyACM0 -c arduino -p m328p -U flash:w:$file_provided
			echo "Burning finished"
		else
			die 'ERROR: You must provide a .c file with -n option'
		fi
		;;
	\?)
		die "ERROR: Invalid option: -$OPTARG" >&2
		;;
	:) die "ERROR: You must specify an file with -n option" ;;
	esac
done
