#!/bin/bash

READ="/home/dcslab/benchmark/read_0.sh"
WRITE="/home/dcslab/benchmark/write_0.sh"


sh $READ $(bc <<< "scale=2;(900 - ${1}) / 0.33")
sh $WRITE ${1}

echo "read_nvme0n1:"
echo $(bc <<< "scale=2;(900 - ${1}) / 0.33")
echo "write_nvme0n1:"
echo ${1}


#sh $READ ${1}
#sh $WRITE $(bc <<< "scale=2; -0.33 * ${1} + 900")
#echo "read:"
#echo ${1}
#echo "write:"
#echo $(bc <<< "scale=0; -0.33 * ${1} + 900")
