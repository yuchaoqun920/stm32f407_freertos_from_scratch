#!/usr/bin/env bash
rm zebra.*
# make clean
make UNITTEST=1
if [ "$?" -ne "0" ]; then
exit $?
fi
# st-flash erase
st-flash --reset write ./zebra.bin 0x8000000
#st-flash --reset write ./*.bin 0x8000000
