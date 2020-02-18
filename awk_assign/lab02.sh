#!/bin/bash

function help1(){
	echo "Usage: $0 file1 file2"
	echo "   you must give 2 names file1 and file2 as argument which can be any name of the 2 files"
	exit
}


function help2(){
	echo "input file $1 does not exist"
	echo "   file having name of first argument must exist to run this script"
	exit
}


if [ $# != 2 ]
then
	help1
fi

if [ ! -f $1 ]
then
	help2 "$1"
fi

sed -e "s/;/@/g" $1
awk -F\; -f japan.awk $1 > $2
awk -F\; 'NR != 1 {if ($6 > 4000) {print $1":"$6}}' $1 >> $2
awk -F\; -f aa.awk $1 >> $2
