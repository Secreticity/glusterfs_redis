#!/bin/bash

RESULT="0522_CLIENT_IOTRACE_goal:$1"
#RESULT="TEST_190510"
 
> $RESULT



############adaptive
#1.0tb
COUNT=36
TIME=2961

#1.3tb
#COUNT=47
#TIME=2665

#1.6tba
#COUNT=58
#TIME=2351

#1.9tb
#COUNT=69
#TIME=1368

#2.2tb
#COUNT=80
#TIME=1584






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


#prg=(3 4 5 7 8 10 12 13 15 17 18 19 20 21 22 24 25 27 28 30 31 34 36 37 38 39 40)
#mul=(6 4 23 98 100 120 440 1150 1370 6 870 150 190 180 4 240 2 7 1 3 15 1 3 1 2 3 2)

prg=(17 18 19 20 30 35)
mul=(3 700 100 150 1000 800)

TIME=`date +'%s'`
echo "start time: $TIME"
echo "expected finish time: $(($TIME + 3800))"
echo "start time: $TIME" >> $RESULT
echo "expected finish time: $(($TIME + 3800))" >> $RESULT

breaktime=0
tmp=1
SET=$(seq 0 $COUNT)
for i in $SET
do
	CUR_TIME=`date +'%s'`
	echo "current time: $CUR_TIME" >> $RESULT
	echo "current time: $CUR_TIME"
	echo `df -h /mnt/jw210 | awk '{ print $3 }' | tail -n 1` >> $RESULT
	
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4))	
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 1))	
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 2))	
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 3))	

	#echo "START========================================================================================================" >> $RESULT
	echo "S$(($(date +%s%N)/1000000))" >> $RESULT
	
	echo $((i*4))
	(cd /mnt/jw$((i*4)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4))) &
	echo $((i*4 + 1))
	(cd /mnt/jw$((i*4+1)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4+1))) &
	echo $((i*4 + 2))
	(cd /mnt/jw$((i*4+2)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4+2))) &
	echo $((i*4 + 3))
	(cd /mnt/jw$((i*4+3)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4+3)))

	echo "E$(($(date +%s%N)/1000000))" >> $RESULT
	#echo "END==========================================================================================================" >> $RESULT

	#umount -l /mnt/jw$((i*4))
	#umount -l /mnt/jw$((i*4 + 1))
	#umount -l /mnt/jw$((i*4 + 2))
	#umount -l /mnt/jw$((i*4 + 3))

	echo "sleep for ${rand[$tmp]} seconds" >> $RESULT
	echo "sleep for ${rand[$tmp]} seconds"
	sleep ${rand[$tmp]}
	
	breaktime=`echo $breaktime + ${rand[$tmp]} | bc`
	echo "current total breaktime $breaktime seconds"
	let "tmp += 1"

done

TIME=`date +'%s'`
echo "end time: $TIME"
echo "end time: $TIME" >> $RESULT



