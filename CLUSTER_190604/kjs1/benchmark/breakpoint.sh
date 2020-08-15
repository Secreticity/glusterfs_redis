#!/bin/bash



while [ 1 ]
do
	perf=`iostat -d nvme3n1 1 2 | tail -n 2 | awk '{print $4}'`
	if [ $perf -eq 0.00 ]
		then
			echo "break"
		else
			echo ${ret}
	fi
done

