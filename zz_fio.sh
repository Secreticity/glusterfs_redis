#!/bin/bash

RESULT="0520_optimize_adaptive_$1_$2_$3"
#RESULT="TEST_190510"
 
> $RESULT



############static
#1.0tb
#COUNT=38
#TIME=2791

#1.3tb
COUNT=36
TIME=2548

#1.6tb
#COUNT=44
#TIME=2306

#1.9tb
#COUNT=53
#TIME=1535
#TIME=1400

###########adaptive
#1.0tb
#COUNT=38
#TIME=2761

#1.3tb
#COUNT=47
#TIME=2456

#1.6tb
#COUNT=58
#TIME=2151

#1.9tb
#COUNT=69
#TIME=1835








tmp=1
declare -a rand

while [ "$tmp" -le $COUNT ];
do
	rand[$tmp]=$(($RANDOM%1000))
	let "sum += ${rand[$tmp]}"
	let "tmp += 1"
done

tmp=1
while [ "$tmp" -le $COUNT ];
do
	rand[$tmp]=$(echo "scale=4; ${rand[$tmp]} / $sum" | bc -l)
	rand[$tmp]=$(echo "scale=4; ${rand[$tmp]} * $TIME" | bc -l)
	let "tmp += 1"
done

echo "${rand[*]}"

TIME=`date +'%s'`
echo "start time: $TIME"
echo "expected finish time: $(($TIME + 3600))"
echo "start time: $TIME" >> $RESULT
echo "expected finish time: $(($TIME + 3600))" >> $RESULT


breaktime=0
tmp=1
SET=$(seq 0 $COUNT)
for i in $SET
do
	CUR_TIME=`date +'%s'`
	echo "current time: $CUR_TIME"
	echo "current time: $CUR_TIME" >> $RESULT
	

	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4))	
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 1))	
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 2))	
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 3))	

	if [ ${i} -eq 27 ]
	then
		echo "full!"
		echo '1' | sshpass -p "dcs5583" ssh -o strictHostKeyChecking=no root@bbkjs0 -T "cat > /mnt/full"
	fi

	echo "START========================================================================================================" >> $RESULT
	echo $(($(date +%s%N)/1000000)) >> $RESULT
	
	echo $((i*4))
	fio --directory=/mnt/jw$((i*4)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=def$(($i*4)) >> $RESULT  &
	echo $((i*4 + 1))
	fio --directory=/mnt/jw$((i*4 + 1)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=def$(($i*4 + 1)) >> $RESULT &
	echo $((i*4 + 2))
	fio --directory=/mnt/jw$((i*4 + 2)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=def$(($i*4 + 2)) >> $RESULT &
	echo $((i*4 + 3))
	fio --directory=/mnt/jw$((i*4 + 3)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=def$(($i*4 + 3)) >> $RESULT 
	
	echo "END==========================================================================================================" >> $RESULT

	#umount -l /mnt/jw$((i*4))
	#umount -l /mnt/jw$((i*4 + 1))
	#umount -l /mnt/jw$((i*4 + 2))
	#umount -l /mnt/jw$((i*4 + 3))

	

	#echo "sleep for ${rand[$tmp]} seconds" >> $RESULT
	#echo "sleep for ${rand[$tmp]} seconds"
	#sleep ${rand[$tmp]}
	#breaktime=`echo $breaktime + ${rand[$tmp]} | bc`
	#echo "current total breaktime $breaktime seconds"
	#let "tmp += 1"

done

TIME=`date +'%s'`
echo "end time: $TIME"
echo "end time: $TIME" >> $RESULT






#echo '1' | sshpass -p "dcs5583" ssh -o strictHostKeyChecking=no root@bbkjs1 -T "cat > /mnt/current_space"



