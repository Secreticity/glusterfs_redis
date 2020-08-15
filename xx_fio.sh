#!/bin/bash

RESULT="static_$1_$2_$3"

#umount -l /mnt/jw
#umount -l /mnt/jw1
#umount -l /mnt/jw2
#umount -l /mnt/jw3

#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw
#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw1
#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw2
#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw3


> $RESULT

SET=$(seq 0 8)
for i in $SET
do
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4))	
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 1))	
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 2))	
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 3))	

	echo "START========================================================================================================" >> $RESULT
	echo $(($(date +%s%N)/1000000)) >> $RESULT
	
	echo $((i*4))
	fio --directory=/mnt/jw$((i*4)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4)) >> $RESULT  &
	echo $((i*4 + 1))
	fio --directory=/mnt/jw$((i*4 + 1)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4 + 1)) >> $RESULT &
	echo $((i*4 + 2))
	fio --directory=/mnt/jw$((i*4 + 2)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4 + 2)) >> $RESULT &
	echo $((i*4 + 3))
	fio --directory=/mnt/jw$((i*4 + 3)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4 + 3)) >> $RESULT 
	
	echo "END==========================================================================================================" >> $RESULT

	umount -l /mnt/jw$((i*4))
	umount -l /mnt/jw$((i*4 + 1))
	umount -l /mnt/jw$((i*4 + 2))
	umount -l /mnt/jw$((i*4 + 3))
done

:<<'END'
SET=$(seq 0 1)
for i in $SET
do
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4))	
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 1))	
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 2))	
	mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/jw$((i*4 + 3))	

	echo "START========================================================================================================" >> $RESULT
	echo $(($(date +%s%N)/1000000)) >> $RESULT
	
	echo $((i*4))
	fio --directory=/mnt/jw$((i*4)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4)) >> $RESULT  &
	echo $((i*4 + 1))
	fio --directory=/mnt/jw$((i*4 + 1)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4 + 1)) >> $RESULT &
	echo $((i*4 + 2))
	fio --directory=/mnt/jw$((i*4 + 2)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4 + 2)) >> $RESULT &
	echo $((i*4 + 3))
	fio --directory=/mnt/jw$((i*4 + 3)) --rw=write --direct=1 --bs=1M --size=1G --numjobs=20 --group_reporting --fallocate=none --name=$(($i*4 + 3)) >> $RESULT 
	
	echo "END==========================================================================================================" >> $RESULT

	umount -l /mnt/jw$((i*4))
	umount -l /mnt/jw$((i*4 + 1))
	umount -l /mnt/jw$((i*4 + 2))
	umount -l /mnt/jw$((i*4 + 3))
done
END
