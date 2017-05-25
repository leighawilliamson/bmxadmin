#!/bin/bash

arg1=$1
log_file="bmxadmin.log"

if [[ -n "$arg1" ]]; then
#    echo "$1=$( date +%s )" >> ${log_file}
	echo "arg is: " $arg1
else
    echo "argument error"
fi

while read -r line 
do 
	echo ${line}
#   command ${line} > ${line}.txt
done< "file"
