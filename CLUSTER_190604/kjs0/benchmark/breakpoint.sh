#!/bin/bash



while [ 1 ]
do
	ret=`iostat -d nvme2n1 1 2 | tail -n 2 | awk '{print $4}'`
	echo ${ret}
done

