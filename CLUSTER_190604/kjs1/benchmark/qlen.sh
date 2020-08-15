#!/bin/bash

#while [ 1 ]
#do
#	qlen= iostat -xmt | awk '/nvme2n1/ { print $9}'
#	echo $qlen
#	sleep 1
#done

file="/home/dcslab/benchmark/${1}.txt"

rm ${file}
while [ 1 ]
do
	ret=iostat -xmtc 1 2 ${1} | tail -n 2 | awk '{ print $9}'
	echo ${ret}
done


#while [ 1 ]
#do
#	echo "" > ${file}
#	echo `iostat -xmt ${1} 1 > ${file}`
#	tag=$( tail -n 1 ${file} )
#	echo ${tag}
#done
