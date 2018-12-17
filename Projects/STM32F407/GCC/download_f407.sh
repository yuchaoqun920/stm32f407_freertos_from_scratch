#!/usr/bin/env bash
rm f407.*
# make clean
make
if [ "$?" -ne "0" ]; then
exit $?
fi
# st-flash erase
st-flash --reset write ./f407.bin 0x8000000
#st-flash --reset write ./*.bin 0x8000000
