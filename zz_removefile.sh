#!/bin/bash

SET=$(seq 0 320)
for i in $SET
do
	echo $i
	#mkdir /mnt/jw$i





	umount -l /mnt/jw$i
	#rm -rf /mnt/td$i/*
	rm -rf /mnt/jw$i/*
	#mount -t glusterfs -o reader-thread-count=2 bbkjs0:/nvv /mnt/jw$i
	#mount -t glusterfs -o reader-thread-count=2 bbkjs1:/nvv /mnt/td$i
done

