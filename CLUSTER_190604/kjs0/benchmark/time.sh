#!/bin/bash

RESULT="result"


TIME=`date +'%s'`

while [ 1 ]
do
	CUR_TIME=`date +'%s'`
	#CUR_TIME=`date +'%H%M%S'`
	echo "$CUR_TIME"
	


#-----------------------------------------------
#0
	if [ $(($TIME + 0)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_3

		fio --directory=/mnt/C0_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_0 >> $RESULT &
		fio --directory=/mnt/C0_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_1 >> $RESULT &
		fio --directory=/mnt/C0_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_2 >> $RESULT &
		fio --directory=/mnt/C0_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_3 >> $RESULT 

		#umount -l /mnt/C0_0
		#umount -l /mnt/C0_1
		#umount -l /mnt/C0_2
		#umount -l /mnt/C0_3
	fi
	
	if [ $(($TIME + 30)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_3

		fio --directory=/mnt/C1_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_0 >> $RESULT &
		fio --directory=/mnt/C1_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_1 >> $RESULT &
		fio --directory=/mnt/C1_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_2 >> $RESULT &
		fio --directory=/mnt/C1_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_3 >> $RESULT 

		#umount -l /mnt/C1_0
		#umount -l /mnt/C1_1
		#umount -l /mnt/C1_2
		#umount -l /mnt/C1_3
	fi


	if [ $(($TIME + 60)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_3

		fio --directory=/mnt/C2_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_0 >> $RESULT &
		fio --directory=/mnt/C2_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_1 >> $RESULT &
		fio --directory=/mnt/C2_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_2 >> $RESULT &
		fio --directory=/mnt/C2_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_3 >> $RESULT 

		#umount -l /mnt/C2_0
		#umount -l /mnt/C2_1
		#umount -l /mnt/C2_2
		#umount -l /mnt/C2_3
	fi
:<<'END'
	if [ $(($TIME + 90)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_3

		fio --directory=/mnt/C3_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_0 >> $RESULT &
		fio --directory=/mnt/C3_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_1 >> $RESULT &
		fio --directory=/mnt/C3_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_2 >> $RESULT &
		fio --directory=/mnt/C3_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_3 >> $RESULT &

		#umount -l /mnt/C3_0
		#umount -l /mnt/C3_1
		#umount -l /mnt/C3_2
		#umount -l /mnt/C3_3
	
	
	fi

	if [ $(($TIME + 120)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_3

		fio --directory=/mnt/C4_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_0 >> $RESULT &
		fio --directory=/mnt/C4_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_1 >> $RESULT &
		fio --directory=/mnt/C4_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_2 >> $RESULT &
		fio --directory=/mnt/C4_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_3 >> $RESULT &

		#umount -l /mnt/C4_0
		#umount -l /mnt/C4_1
		#umount -l /mnt/C4_2
		#umount -l /mnt/C4_3
	
	fi

	if [ $(($TIME + 150)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_3

		fio --directory=/mnt/C5_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_0 >> $RESULT &
		fio --directory=/mnt/C5_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_1 >> $RESULT &
		fio --directory=/mnt/C5_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_2 >> $RESULT &
		fio --directory=/mnt/C5_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_3 >> $RESULT &

		#umount -l /mnt/C5_0
		#umount -l /mnt/C5_1
		#umount -l /mnt/C5_2
		#umount -l /mnt/C5_3
	
	fi

	if [ $(($TIME + 180)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_3

		fio --directory=/mnt/C6_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_0 >> $RESULT &
		fio --directory=/mnt/C6_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_1 >> $RESULT &
		fio --directory=/mnt/C6_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_2 >> $RESULT &
		fio --directory=/mnt/C6_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_3 >> $RESULT &

		#umount -l /mnt/C6_0
		#umount -l /mnt/C6_1
		#umount -l /mnt/C6_2
		#umount -l /mnt/C6_3
	
	fi

	if [ $(($TIME + 210)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_3

		fio --directory=/mnt/C7_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_0 >> $RESULT &
		fio --directory=/mnt/C7_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_1 >> $RESULT &
		fio --directory=/mnt/C7_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_2 >> $RESULT &
		fio --directory=/mnt/C7_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_3 >> $RESULT &

		#umount -l /mnt/C7_0
		#umount -l /mnt/C7_1
		#umount -l /mnt/C7_2
		#umount -l /mnt/C7_3
	
	fi

	if [ $(($TIME + 240)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_3

		fio --directory=/mnt/B0_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_0 >> $RESULT &
		fio --directory=/mnt/B0_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_1 >> $RESULT &
		fio --directory=/mnt/B0_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_2 >> $RESULT &
		fio --directory=/mnt/B0_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_3 >> $RESULT &

		#umount -l /mnt/B0_0
		#umount -l /mnt/B0_1
		#umount -l /mnt/B0_2
		#umount -l /mnt/B0_3
	
	fi

	if [ $(($TIME + 270)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_3

		fio --directory=/mnt/B1_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_0 >> $RESULT &
		fio --directory=/mnt/B1_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_1 >> $RESULT &
		fio --directory=/mnt/B1_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_2 >> $RESULT &
		fio --directory=/mnt/B1_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_3 >> $RESULT &

		#umount -l /mnt/B1_0
		#umount -l /mnt/B1_1
		#umount -l /mnt/B1_2
		#umount -l /mnt/B1_3
	
	fi
	
#------------------------------------------------
#10
	if [ $(($TIME + 300)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_3

		fio --directory=/mnt/B2_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_0 >> $RESULT &
		fio --directory=/mnt/B2_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_1 >> $RESULT &
		fio --directory=/mnt/B2_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_2 >> $RESULT &
		fio --directory=/mnt/B2_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_3 >> $RESULT &

		#umount -l /mnt/B2_0
		#umount -l /mnt/B2_1
		#umount -l /mnt/B2_2
		#umount -l /mnt/B2_3
	
	fi
	
	if [ $(($TIME + 330)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_3

		fio --directory=/mnt/B3_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_0 >> $RESULT &
		fio --directory=/mnt/B3_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_1 >> $RESULT &
		fio --directory=/mnt/B3_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_2 >> $RESULT &
		fio --directory=/mnt/B3_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_3 >> $RESULT &

		#umount -l /mnt/B3_0
		#umount -l /mnt/B3_1
		#umount -l /mnt/B3_2
		#umount -l /mnt/B3_3
	
	fi

	if [ $(($TIME + 360)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_3

		fio --directory=/mnt/B4_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_0 >> $RESULT &
		fio --directory=/mnt/B4_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_1 >> $RESULT &
		fio --directory=/mnt/B4_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_2 >> $RESULT &
		fio --directory=/mnt/B4_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_3 >> $RESULT &

		#umount -l /mnt/B4_0
		#umount -l /mnt/B4_1
		#umount -l /mnt/B4_2
		#umount -l /mnt/B4_3
	
	fi

	if [ $(($TIME + 390)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_3

		fio --directory=/mnt/B5_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_0 >> $RESULT &
		fio --directory=/mnt/B5_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_1 >> $RESULT &
		fio --directory=/mnt/B5_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_2 >> $RESULT &
		fio --directory=/mnt/B5_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_3 >> $RESULT &

		#umount -l /mnt/B5_0
		#umount -l /mnt/B5_1
		#umount -l /mnt/B5_2
		#umount -l /mnt/B5_3

	fi

	if [ $(($TIME + 420)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_3

		fio --directory=/mnt/B6_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_0 >> $RESULT &
		fio --directory=/mnt/B6_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_1 >> $RESULT &
		fio --directory=/mnt/B6_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_2 >> $RESULT &
		fio --directory=/mnt/B6_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_3 >> $RESULT &

		#umount -l /mnt/B6_0
		#umount -l /mnt/B6_1
		#umount -l /mnt/B6_2
		#umount -l /mnt/B6_3
	
	fi

	if [ $(($TIME + 450)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_3

		fio --directory=/mnt/B7_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_0 >> $RESULT &
		fio --directory=/mnt/B7_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_1 >> $RESULT &
		fio --directory=/mnt/B7_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_2 >> $RESULT &
		fio --directory=/mnt/B7_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_3 >> $RESULT &

		#umount -l /mnt/B7_0
		#umount -l /mnt/B7_1
		#umount -l /mnt/B7_2
		#umount -l /mnt/B7_3
	
	fi

	if [ $(($TIME + 480)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_3

		fio --directory=/mnt/B8_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_0 >> $RESULT &
		fio --directory=/mnt/B8_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_1 >> $RESULT &
		fio --directory=/mnt/B8_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_2 >> $RESULT &
		fio --directory=/mnt/B8_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_3 >> $RESULT &

		#umount -l /mnt/B8_0
		#umount -l /mnt/B8_1
		#umount -l /mnt/B8_2
		#umount -l /mnt/B8_3
	
	fi

	if [ $(($TIME + 510)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_3

		fio --directory=/mnt/B9_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_0 >> $RESULT &
		fio --directory=/mnt/B9_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_1 >> $RESULT &
		fio --directory=/mnt/B9_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_2 >> $RESULT &
		fio --directory=/mnt/B9_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_3 >> $RESULT &

		#umount -l /mnt/B9_0
		#umount -l /mnt/B9_1
		#umount -l /mnt/B9_2
		#umount -l /mnt/B9_3
	
	fi

	if [ $(($TIME + 540)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_3

		fio --directory=/mnt/B10_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_0 >> $RESULT &
		fio --directory=/mnt/B10_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_1 >> $RESULT &
		fio --directory=/mnt/B10_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_2 >> $RESULT &
		fio --directory=/mnt/B10_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_3 >> $RESULT &

		#umount -l /mnt/B10_0
		#umount -l /mnt/B10_1
		#umount -l /mnt/B10_2
		#umount -l /mnt/B10_3
	
	fi

	if [ $(($TIME + 570)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_3

		fio --directory=/mnt/C8_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_0 >> $RESULT &
		fio --directory=/mnt/C8_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_1 >> $RESULT &
		fio --directory=/mnt/C8_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_2 >> $RESULT &
		fio --directory=/mnt/C8_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_3 >> $RESULT &

		#umount -l /mnt/C8_0
		#umount -l /mnt/C8_1
		#umount -l /mnt/C8_2
		#umount -l /mnt/C8_3
	
	fi

#------------------------------------------------
#20
	if [ $(($TIME + 600)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_3

		fio --directory=/mnt/C9_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_0 >> $RESULT &
		fio --directory=/mnt/C9_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_1 >> $RESULT &
		fio --directory=/mnt/C9_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_2 >> $RESULT &
		fio --directory=/mnt/C9_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_3 >> $RESULT &

		#umount -l /mnt/C9_0
		#umount -l /mnt/C9_1
		#umount -l /mnt/C9_2
		#umount -l /mnt/C9_3
	
	fi
	
	if [ $(($TIME + 630)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_3

		fio --directory=/mnt/C10_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_0 >> $RESULT &
		fio --directory=/mnt/C10_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_1 >> $RESULT &
		fio --directory=/mnt/C10_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_2 >> $RESULT &
		fio --directory=/mnt/C10_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_3 >> $RESULT &

		#umount -l /mnt/C10_0
		#umount -l /mnt/C10_1
		#umount -l /mnt/C10_2
		#umount -l /mnt/C10_3
	
	fi

	if [ $(($TIME + 660)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_3

		fio --directory=/mnt/C11_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_0 >> $RESULT &
		fio --directory=/mnt/C11_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_1 >> $RESULT &
		fio --directory=/mnt/C11_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_2 >> $RESULT &
		fio --directory=/mnt/C11_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_3 >> $RESULT &

		#umount -l /mnt/C11_0
		#umount -l /mnt/C11_1
		#umount -l /mnt/C11_2
		#umount -l /mnt/C11_3
	
	fi

	if [ $(($TIME + 720)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A0_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A0_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A0_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A0_3

		fio --directory=/mnt/A0_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A0_0 >> $RESULT &
		fio --directory=/mnt/A0_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A0_1 >> $RESULT &
		fio --directory=/mnt/A0_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A0_2 >> $RESULT &
		fio --directory=/mnt/A0_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A0_3 >> $RESULT &

		#umount -l /mnt/A0_0
		#umount -l /mnt/A0_1
		#umount -l /mnt/A0_2
		#umount -l /mnt/A0_3
	
	fi

	if [ $(($TIME + 750)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A1_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A1_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A1_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A1_3

		fio --directory=/mnt/A1_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A1_0 >> $RESULT &
		fio --directory=/mnt/A1_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A1_1 >> $RESULT &
		fio --directory=/mnt/A1_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A1_2 >> $RESULT &
		fio --directory=/mnt/A1_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A1_3 >> $RESULT &

		#umount -l /mnt/A1_0
		#umount -l /mnt/A1_1
		#umount -l /mnt/A1_2
		#umount -l /mnt/A1_3
	
	fi

	if [ $(($TIME + 780)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A2_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A2_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A2_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A2_3

		fio --directory=/mnt/A2_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A2_0 >> $RESULT &
		fio --directory=/mnt/A2_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A2_1 >> $RESULT &
		fio --directory=/mnt/A2_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A2_2 >> $RESULT &
		fio --directory=/mnt/A2_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A2_3 >> $RESULT &

		#umount -l /mnt/A2_0
		#umount -l /mnt/A2_1
		#umount -l /mnt/A2_2
		#umount -l /mnt/A2_3
	
	fi

	if [ $(($TIME + 840)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_3

		fio --directory=/mnt/B11_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_0 >> $RESULT &
		fio --directory=/mnt/B11_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_1 >> $RESULT &
		fio --directory=/mnt/B11_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_2 >> $RESULT &
		fio --directory=/mnt/B11_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_3 >> $RESULT &

		#umount -l /mnt/B11_0
		#umount -l /mnt/B11_1
		#umount -l /mnt/B11_2
		#umount -l /mnt/B11_3
	
	fi

	if [ $(($TIME + 870)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_3

		fio --directory=/mnt/B12_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_0 >> $RESULT &
		fio --directory=/mnt/B12_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_1 >> $RESULT &
		fio --directory=/mnt/B12_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_2 >> $RESULT &
		fio --directory=/mnt/B12_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_3 >> $RESULT &

		#umount -l /mnt/B12_0
		#umount -l /mnt/B12_1
		#umount -l /mnt/B12_2
		#umount -l /mnt/B12_3
	
	fi

	if [ $(($TIME + 900)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A3_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A3_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A3_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A3_3

		fio --directory=/mnt/A3_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A3_0 >> $RESULT &
		fio --directory=/mnt/A3_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A3_1 >> $RESULT &
		fio --directory=/mnt/A3_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A3_2 >> $RESULT &
		fio --directory=/mnt/A3_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A3_3 >> $RESULT &

		#umount -l /mnt/A3_0
		#umount -l /mnt/A3_1
		#umount -l /mnt/A3_2
		#umount -l /mnt/A3_3
	
	fi

	if [ $(($TIME + 930)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A4_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A4_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A4_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A4_3

		fio --directory=/mnt/A4_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A4_0 >> $RESULT &
		fio --directory=/mnt/A4_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A4_1 >> $RESULT &
		fio --directory=/mnt/A4_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A4_2 >> $RESULT &
		fio --directory=/mnt/A4_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A4_3 >> $RESULT &

		#umount -l /mnt/A4_0
		#umount -l /mnt/A4_1
		#umount -l /mnt/A4_2
		#umount -l /mnt/A4_3
	
	fi

#------------------------------------------------
#30
	if [ $(($TIME + 960)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A5_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A5_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A5_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A5_3

		fio --directory=/mnt/A5_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A5_0 >> $RESULT &
		fio --directory=/mnt/A5_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A5_1 >> $RESULT &
		fio --directory=/mnt/A5_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A5_2 >> $RESULT &
		fio --directory=/mnt/A5_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A5_3 >> $RESULT &

		#umount -l /mnt/A5_0
		#umount -l /mnt/A5_1
		#umount -l /mnt/A5_2
		#umount -l /mnt/A5_3
	
	fi
	
	if [ $(($TIME + 990)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A6_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A6_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A6_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A6_3

		fio --directory=/mnt/A6_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A6_0 >> $RESULT &
		fio --directory=/mnt/A6_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A6_1 >> $RESULT &
		fio --directory=/mnt/A6_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A6_2 >> $RESULT &
		fio --directory=/mnt/A6_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A6_3 >> $RESULT &

		#umount -l /mnt/A6_0
		#umount -l /mnt/A6_1
		#umount -l /mnt/A6_2
		#umount -l /mnt/A6_3
	
	fi

	if [ $(($TIME + 1020)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A7_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A7_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A7_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A7_3

		fio --directory=/mnt/A7_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A7_0 >> $RESULT &
		fio --directory=/mnt/A7_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A7_1 >> $RESULT &
		fio --directory=/mnt/A7_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A7_2 >> $RESULT &
		fio --directory=/mnt/A7_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A7_3 >> $RESULT &

		#umount -l /mnt/A7_0
		#umount -l /mnt/A7_1
		#umount -l /mnt/A7_2
		#umount -l /mnt/A7_3
	
	fi

	if [ $(($TIME + 1050)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A8_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A8_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A8_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A8_3

		fio --directory=/mnt/A8_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A8_0 >> $RESULT &
		fio --directory=/mnt/A8_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A8_1 >> $RESULT &
		fio --directory=/mnt/A8_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A8_2 >> $RESULT &
		fio --directory=/mnt/A8_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A8_3 >> $RESULT &

		#umount -l /mnt/A8_0
		#umount -l /mnt/A8_1
		#umount -l /mnt/A8_2
		#umount -l /mnt/A8_3
	
	fi

	if [ $(($TIME + 1080)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A9_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A9_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A9_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A9_3

		fio --directory=/mnt/A9_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A9_0 >> $RESULT &
		fio --directory=/mnt/A9_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A9_1 >> $RESULT &
		fio --directory=/mnt/A9_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A9_2 >> $RESULT &
		fio --directory=/mnt/A9_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A9_3 >> $RESULT &

		#umount -l /mnt/A9_0
		#umount -l /mnt/A9_1
		#umount -l /mnt/A9_2
		#umount -l /mnt/A9_3
	
	fi

	if [ $(($TIME + 1200)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_3

		fio --directory=/mnt/C0_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_0_v1 >> $RESULT &
		fio --directory=/mnt/C0_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_1_v1 >> $RESULT &
		fio --directory=/mnt/C0_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_2_v1 >> $RESULT &
		fio --directory=/mnt/C0_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_3_v1 >> $RESULT &

		#umount -l /mnt/C0_0
		#umount -l /mnt/C0_1
		#umount -l /mnt/C0_2
		#umount -l /mnt/C0_3
	
	fi

	if [ $(($TIME + 1230)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_3

		fio --directory=/mnt/C1_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_0_v1 >> $RESULT &
		fio --directory=/mnt/C1_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_1_v1 >> $RESULT &
		fio --directory=/mnt/C1_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_2_v1 >> $RESULT &
		fio --directory=/mnt/C1_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_3_v1 >> $RESULT &

		#umount -l /mnt/C1_0
		#umount -l /mnt/C1_1
		#umount -l /mnt/C1_2
		#umount -l /mnt/C1_3
	
	fi

	if [ $(($TIME + 1260)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_3

		fio --directory=/mnt/C2_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_0_v1 >> $RESULT &
		fio --directory=/mnt/C2_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_1_v1 >> $RESULT &
		fio --directory=/mnt/C2_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_2_v1 >> $RESULT &
		fio --directory=/mnt/C2_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_3_v1 >> $RESULT &

		#umount -l /mnt/C2_0
		#umount -l /mnt/C2_1
		#umount -l /mnt/C2_2
		#umount -l /mnt/C2_3
	
	fi

	if [ $(($TIME + 1290)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_3

		fio --directory=/mnt/C3_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_0_v1 >> $RESULT &
		fio --directory=/mnt/C3_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_1_v1 >> $RESULT &
		fio --directory=/mnt/C3_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_2_v1 >> $RESULT &
		fio --directory=/mnt/C3_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_3_v1 >> $RESULT &

		#umount -l /mnt/C3_0
		#umount -l /mnt/C3_1
		#umount -l /mnt/C3_2
		#umount -l /mnt/C3_3
	
	fi

	if [ $(($TIME + 1320)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_3

		fio --directory=/mnt/C4_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_0_v1 >> $RESULT &
		fio --directory=/mnt/C4_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_1_v1 >> $RESULT &
		fio --directory=/mnt/C4_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_2_v1 >> $RESULT &
		fio --directory=/mnt/C4_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_3_v1 >> $RESULT &

		#umount -l /mnt/C4_0
		#umount -l /mnt/C4_1
		#umount -l /mnt/C4_2
		#umount -l /mnt/C4_3
	
	fi

#------------------------------------------------
#40
	if [ $(($TIME + 1350)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_3

		fio --directory=/mnt/C5_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_0_v1 >> $RESULT &
		fio --directory=/mnt/C5_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_1_v1 >> $RESULT &
		fio --directory=/mnt/C5_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_2_v1 >> $RESULT &
		fio --directory=/mnt/C5_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_3_v1 >> $RESULT &

		#umount -l /mnt/C5_0
		#umount -l /mnt/C5_1
		#umount -l /mnt/C5_2
		#umount -l /mnt/C5_3
	
	fi
	
	if [ $(($TIME + 1380)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_3

		fio --directory=/mnt/C6_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_0_v1 >> $RESULT &
		fio --directory=/mnt/C6_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_1_v1 >> $RESULT &
		fio --directory=/mnt/C6_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_2_v1 >> $RESULT &
		fio --directory=/mnt/C6_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_3_v1 >> $RESULT &

		#umount -l /mnt/C6_0
		#umount -l /mnt/C6_1
		#umount -l /mnt/C6_2
		#umount -l /mnt/C6_3
	
	fi

	if [ $(($TIME + 1410)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_3

		fio --directory=/mnt/C7_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_0_v1 >> $RESULT &
		fio --directory=/mnt/C7_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_1_v1 >> $RESULT &
		fio --directory=/mnt/C7_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_2_v1 >> $RESULT &
		fio --directory=/mnt/C7_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_3_v1 >> $RESULT &

		#umount -l /mnt/C7_0
		#umount -l /mnt/C7_1
		#umount -l /mnt/C7_2
		#umount -l /mnt/C7_3
	
	fi

	if [ $(($TIME + 1770)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_3

		fio --directory=/mnt/C8_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_0_v1 >> $RESULT &
		fio --directory=/mnt/C8_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_1_v1 >> $RESULT &
		fio --directory=/mnt/C8_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_2_v1 >> $RESULT &
		fio --directory=/mnt/C8_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_3_v1 >> $RESULT &

		#umount -l /mnt/C8_0
		#umount -l /mnt/C8_1
		#umount -l /mnt/C8_2
		#umount -l /mnt/C8_3
	
	fi

	if [ $(($TIME + 1800)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_3

		fio --directory=/mnt/C9_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_0_v1 >> $RESULT &
		fio --directory=/mnt/C9_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_1_v1 >> $RESULT &
		fio --directory=/mnt/C9_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_2_v1 >> $RESULT &
		fio --directory=/mnt/C9_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_3_v1 >> $RESULT &

		#umount -l /mnt/C9_0
		#umount -l /mnt/C9_1
		#umount -l /mnt/C9_2
		#umount -l /mnt/C9_3
	
	fi

	if [ $(($TIME + 1830)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_3

		fio --directory=/mnt/C10_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_0_v1 >> $RESULT &
		fio --directory=/mnt/C10_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_1_v1 >> $RESULT &
		fio --directory=/mnt/C10_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_2_v1 >> $RESULT &
		fio --directory=/mnt/C10_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_3_v1 >> $RESULT &

		#umount -l /mnt/C10_0
		#umount -l /mnt/C10_1
		#umount -l /mnt/C10_2
		#umount -l /mnt/C10_3
	
	fi

	if [ $(($TIME + 1860)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_3

		fio --directory=/mnt/C11_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_0_v1 >> $RESULT &
		fio --directory=/mnt/C11_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_1_v1 >> $RESULT &
		fio --directory=/mnt/C11_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_2_v1 >> $RESULT &
		fio --directory=/mnt/C11_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_3_v1 >> $RESULT &

		#umount -l /mnt/C11_0
		#umount -l /mnt/C11_1
		#umount -l /mnt/C11_2
		#umount -l /mnt/C11_3
	
	fi

	if [ $(($TIME + 2040)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B0_3

		fio --directory=/mnt/B0_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_0_v1 >> $RESULT &
		fio --directory=/mnt/B0_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_1_v1 >> $RESULT &
		fio --directory=/mnt/B0_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_2_v1 >> $RESULT &
		fio --directory=/mnt/B0_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B0_3_v1 >> $RESULT &

		#umount -l /mnt/B0_0
		#umount -l /mnt/B0_1
		#umount -l /mnt/B0_2
		#umount -l /mnt/B0_3
	
	fi

	if [ $(($TIME + 2030)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B1_3

		fio --directory=/mnt/B1_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_0_v1 >> $RESULT &
		fio --directory=/mnt/B1_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_1_v1 >> $RESULT &
		fio --directory=/mnt/B1_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_2_v1 >> $RESULT &
		fio --directory=/mnt/B1_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B1_3_v1 >> $RESULT &

		#umount -l /mnt/B1_0
		#umount -l /mnt/B1_1
		#umount -l /mnt/B1_2
		#umount -l /mnt/B1_3
	
	fi

	if [ $(($TIME + 2100)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B2_3

		fio --directory=/mnt/B2_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_0_v1 >> $RESULT &
		fio --directory=/mnt/B2_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_1_v1 >> $RESULT &
		fio --directory=/mnt/B2_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_2_v1 >> $RESULT &
		fio --directory=/mnt/B2_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B2_3_v1 >> $RESULT &

		#umount -l /mnt/B2_0
		#umount -l /mnt/B2_1
		#umount -l /mnt/B2_2
		#umount -l /mnt/B2_3
	
	fi

#------------------------------------------------
#50
	if [ $(($TIME + 2130)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B3_3

		fio --directory=/mnt/B3_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_0_v1 >> $RESULT &
		fio --directory=/mnt/B3_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_1_v1 >> $RESULT &
		fio --directory=/mnt/B3_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_2_v1 >> $RESULT &
		fio --directory=/mnt/B3_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B3_3_v1 >> $RESULT &

		#umount -l /mnt/B3_0
		#umount -l /mnt/B3_1
		#umount -l /mnt/B3_2
		#umount -l /mnt/B3_3
	
	fi
	
	if [ $(($TIME + 2160)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B4_3

		fio --directory=/mnt/B4_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_0_v1 >> $RESULT &
		fio --directory=/mnt/B4_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_1_v1 >> $RESULT &
		fio --directory=/mnt/B4_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_2_v1 >> $RESULT &
		fio --directory=/mnt/B4_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B4_3_v1 >> $RESULT &

		#umount -l /mnt/B4_0
		#umount -l /mnt/B4_1
		#umount -l /mnt/B4_2
		#umount -l /mnt/B4_3
	
	fi

	if [ $(($TIME + 2190)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B5_3

		fio --directory=/mnt/B5_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_0_v1 >> $RESULT &
		fio --directory=/mnt/B5_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_1_v1 >> $RESULT &
		fio --directory=/mnt/B5_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_2_v1 >> $RESULT &
		fio --directory=/mnt/B5_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B5_3_v1 >> $RESULT &

		#umount -l /mnt/B5_0
		#umount -l /mnt/B5_1
		#umount -l /mnt/B5_2
		#umount -l /mnt/B5_3
	
	fi

	if [ $(($TIME + 2220)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B6_3

		fio --directory=/mnt/B6_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_0_v1 >> $RESULT &
		fio --directory=/mnt/B6_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_1_v1 >> $RESULT &
		fio --directory=/mnt/B6_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_2_v1 >> $RESULT &
		fio --directory=/mnt/B6_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B6_3_v1 >> $RESULT &

		#umount -l /mnt/B6_0
		#umount -l /mnt/B6_1
		#umount -l /mnt/B6_2
		#umount -l /mnt/B6_3
	
	fi

	if [ $(($TIME + 2250)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B7_3

		fio --directory=/mnt/B7_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_0_v1 >> $RESULT &
		fio --directory=/mnt/B7_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_1_v1 >> $RESULT &
		fio --directory=/mnt/B7_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_2_v1 >> $RESULT &
		fio --directory=/mnt/B7_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B7_3_v1 >> $RESULT &

		#umount -l /mnt/B7_0
		#umount -l /mnt/B7_1
		#umount -l /mnt/B7_2
		#umount -l /mnt/B7_3
	
	fi

	if [ $(($TIME + 2280)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B8_3

		fio --directory=/mnt/B8_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_0_v1 >> $RESULT &
		fio --directory=/mnt/B8_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_1_v1 >> $RESULT &
		fio --directory=/mnt/B8_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_2_v1 >> $RESULT &
		fio --directory=/mnt/B8_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B8_3_v1 >> $RESULT &

		#umount -l /mnt/B8_0
		#umount -l /mnt/B8_1
		#umount -l /mnt/B8_2
		#umount -l /mnt/B8_3
	
	fi

	if [ $(($TIME + 2310)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B9_3

		fio --directory=/mnt/B9_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_0_v1 >> $RESULT &
		fio --directory=/mnt/B9_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_1_v1 >> $RESULT &
		fio --directory=/mnt/B9_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_2_v1 >> $RESULT &
		fio --directory=/mnt/B9_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B9_3_v1 >> $RESULT &

		#umount -l /mnt/B9_0
		#umount -l /mnt/B9_1
		#umount -l /mnt/B9_2
		#umount -l /mnt/B9_3
	
	fi

	if [ $(($TIME + 2340)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B10_3

		fio --directory=/mnt/B10_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_0_v1 >> $RESULT &
		fio --directory=/mnt/B10_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_1_v1 >> $RESULT &
		fio --directory=/mnt/B10_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_2_v1 >> $RESULT &
		fio --directory=/mnt/B10_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B10_3_v1 >> $RESULT &

		#umount -l /mnt/B10_0
		#umount -l /mnt/B10_1
		#umount -l /mnt/B10_2
		#umount -l /mnt/B10_3
	
	fi

	if [ $(($TIME + 2400)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C0_3

		fio --directory=/mnt/C0_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_0_v2 >> $RESULT &
		fio --directory=/mnt/C0_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_1_v2 >> $RESULT &
		fio --directory=/mnt/C0_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_2_v2 >> $RESULT &
		fio --directory=/mnt/C0_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C0_3_v2 >> $RESULT &

		#umount -l /mnt/C0_0
		#umount -l /mnt/C0_1
		#umount -l /mnt/C0_2
		#umount -l /mnt/C0_3
	
	fi

	if [ $(($TIME + 2430)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C1_3

		fio --directory=/mnt/C1_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_0_v2 >> $RESULT &
		fio --directory=/mnt/C1_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_1_v2 >> $RESULT &
		fio --directory=/mnt/C1_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_2_v2 >> $RESULT &
		fio --directory=/mnt/C1_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C1_3_v2 >> $RESULT &

		#umount -l /mnt/C1_0
		#umount -l /mnt/C1_1
		#umount -l /mnt/C1_2
		#umount -l /mnt/C1_3
	
	fi

#------------------------------------------------
#60
	if [ $(($TIME + 2460)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C2_3

		fio --directory=/mnt/C2_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_0_v2 >> $RESULT &
		fio --directory=/mnt/C2_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_1_v2 >> $RESULT &
		fio --directory=/mnt/C2_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_2_v2 >> $RESULT &
		fio --directory=/mnt/C2_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C2_3_v2 >> $RESULT &

		#umount -l /mnt/C2_0
		#umount -l /mnt/C2_1
		#umount -l /mnt/C2_2
		#umount -l /mnt/C2_3
	
	fi
	
	if [ $(($TIME + 2490)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C3_3

		fio --directory=/mnt/C3_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_0_v2 >> $RESULT &
		fio --directory=/mnt/C3_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_1_v2 >> $RESULT &
		fio --directory=/mnt/C3_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_2_v2 >> $RESULT &
		fio --directory=/mnt/C3_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C3_3_v2 >> $RESULT &

		#umount -l /mnt/C3_0
		#umount -l /mnt/C3_1
		#umount -l /mnt/C3_2
		#umount -l /mnt/C3_3
	
	fi

	if [ $(($TIME + 2520)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C4_3

		fio --directory=/mnt/C4_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_0_v2 >> $RESULT &
		fio --directory=/mnt/C4_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_1_v2 >> $RESULT &
		fio --directory=/mnt/C4_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_2_v2 >> $RESULT &
		fio --directory=/mnt/C4_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C4_3_v2 >> $RESULT &

		#umount -l /mnt/C4_0
		#umount -l /mnt/C4_1
		#umount -l /mnt/C4_2
		#umount -l /mnt/C4_3
	
	fi

	if [ $(($TIME + 2550)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C5_3

		fio --directory=/mnt/C5_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_0_v2 >> $RESULT &
		fio --directory=/mnt/C5_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_1_v2 >> $RESULT &
		fio --directory=/mnt/C5_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_2_v2 >> $RESULT &
		fio --directory=/mnt/C5_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C5_3_v2 >> $RESULT &

		#umount -l /mnt/C5_0
		#umount -l /mnt/C5_1
		#umount -l /mnt/C5_2
		#umount -l /mnt/C5_3
	
	fi

	if [ $(($TIME + 2580)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C6_3

		fio --directory=/mnt/C6_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_0_v2 >> $RESULT &
		fio --directory=/mnt/C6_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_1_v2 >> $RESULT &
		fio --directory=/mnt/C6_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_2_v2 >> $RESULT &
		fio --directory=/mnt/C6_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C6_3_v2 >> $RESULT &

		#umount -l /mnt/C6_0
		#umount -l /mnt/C6_1
		#umount -l /mnt/C6_2
		#umount -l /mnt/C6_3
	
	fi

	if [ $(($TIME + 2610)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C7_3

		fio --directory=/mnt/C7_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_0_v2 >> $RESULT &
		fio --directory=/mnt/C7_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_1_v2 >> $RESULT &
		fio --directory=/mnt/C7_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_2_v2 >> $RESULT &
		fio --directory=/mnt/C7_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C7_3_v2 >> $RESULT &

		#umount -l /mnt/C7_0
		#umount -l /mnt/C7_1
		#umount -l /mnt/C7_2
		#umount -l /mnt/C7_3
	
	fi

	if [ $(($TIME + 2640)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B11_3

		fio --directory=/mnt/B11_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_0_v1 >> $RESULT &
		fio --directory=/mnt/B11_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_1_v1 >> $RESULT &
		fio --directory=/mnt/B11_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_2_v1 >> $RESULT &
		fio --directory=/mnt/B11_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B11_3_v1 >> $RESULT &

		#umount -l /mnt/B11_0
		#umount -l /mnt/B11_1
		#umount -l /mnt/B11_2
		#umount -l /mnt/B11_3
	
	fi

	if [ $(($TIME + 2670)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/B12_3

		fio --directory=/mnt/B12_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_0_v1 >> $RESULT &
		fio --directory=/mnt/B12_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_1_v1 >> $RESULT &
		fio --directory=/mnt/B12_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_2_v1 >> $RESULT &
		fio --directory=/mnt/B12_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=B12_3_v1 >> $RESULT &

		#umount -l /mnt/B12_0
		#umount -l /mnt/B12_1
		#umount -l /mnt/B12_2
		#umount -l /mnt/B12_3
	
	fi

	if [ $(($TIME + 2970)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C8_3

		fio --directory=/mnt/C1_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_0_v2 >> $RESULT &
		fio --directory=/mnt/C1_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_1_v2 >> $RESULT &
		fio --directory=/mnt/C1_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_2_v2 >> $RESULT &
		fio --directory=/mnt/C1_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C8_3_v2 >> $RESULT &

		#umount -l /mnt/C8_0
		#umount -l /mnt/C8_1
		#umount -l /mnt/C8_2
		#umount -l /mnt/C8_3
	
	fi

	if [ $(($TIME + 3000)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C9_3

		fio --directory=/mnt/C9_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_0_v2 >> $RESULT &
		fio --directory=/mnt/C9_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_1_v2 >> $RESULT &
		fio --directory=/mnt/C9_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_2_v2 >> $RESULT &
		fio --directory=/mnt/C9_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C9_3_v2 >> $RESULT &

		#umount -l /mnt/C9_0
		#umount -l /mnt/C9_1
		#umount -l /mnt/C9_2
		#umount -l /mnt/C9_3
	
	fi

#------------------------------------------------
#70
	if [ $(($TIME + 3030)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C10_3

		fio --directory=/mnt/C10_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_0_v2 >> $RESULT &
		fio --directory=/mnt/C10_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_1_v2 >> $RESULT &
		fio --directory=/mnt/C10_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_2_v2 >> $RESULT &
		fio --directory=/mnt/C10_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C10_3_v2 >> $RESULT &

		#umount -l /mnt/C10_0
		#umount -l /mnt/C10_1
		#umount -l /mnt/C10_2
		#umount -l /mnt/C10_3
	
	fi
	
	if [ $(($TIME + 3060)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/C11_3

		fio --directory=/mnt/C11_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_0_v2 >> $RESULT &
		fio --directory=/mnt/C11_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_1_v2 >> $RESULT &
		fio --directory=/mnt/C11_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_2_v2 >> $RESULT &
		fio --directory=/mnt/C11_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=C11_3_v2 >> $RESULT &

		#umount -l /mnt/C11_0
		#umount -l /mnt/C11_1
		#umount -l /mnt/C11_2
		#umount -l /mnt/C11_3
	
	fi

	if [ $(($TIME + 3200)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A10_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A10_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A10_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A10_3

		fio --directory=/mnt/A10_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A10_0 >> $RESULT &
		fio --directory=/mnt/A10_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A10_1 >> $RESULT &
		fio --directory=/mnt/A10_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A10_2 >> $RESULT &
		fio --directory=/mnt/A10_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A10_3 >> $RESULT &

		#umount -l /mnt/A10_0
		#umount -l /mnt/A10_1
		#umount -l /mnt/A10_2
		#umount -l /mnt/A10_3
	
	fi

	if [ $(($TIME + 3300)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A11_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A11_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A11_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A11_3

		fio --directory=/mnt/A11_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A11_0 >> $RESULT &
		fio --directory=/mnt/A11_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A11_1 >> $RESULT &
		fio --directory=/mnt/A11_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A11_2 >> $RESULT &
		fio --directory=/mnt/A11_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A11_3 >> $RESULT &

		#umount -l /mnt/A11_0
		#umount -l /mnt/A11_1
		#umount -l /mnt/A11_2
		#umount -l /mnt/A11_3
	
	fi

	if [ $(($TIME + 3400)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A12_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A12_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A12_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A12_3

		fio --directory=/mnt/A12_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A12_0 >> $RESULT &
		fio --directory=/mnt/A12_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A12_1 >> $RESULT &
		fio --directory=/mnt/A12_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A12_2 >> $RESULT &
		fio --directory=/mnt/A12_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A12_3 >> $RESULT &

		#umount -l /mnt/A12_0
		#umount -l /mnt/A12_1
		#umount -l /mnt/A12_2
		#umount -l /mnt/A12_3
	
	fi

	if [ $(($TIME + 3500)) -eq $CUR_TIME ]
	then
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A13_0
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A13_1
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A13_2
		mount -t glusterfs -o reader-thread-count=1 bbkjs0:/nvv /mnt/A13_3

		fio --directory=/mnt/A13_0 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A13_0 >> $RESULT &
		fio --directory=/mnt/A13_1 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A13_1 >> $RESULT &
		fio --directory=/mnt/A13_2 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A13_2 >> $RESULT &
		fio --directory=/mnt/A13_3 --rw=write --direct=1 --bs=1M --size=1G --numjobs=5 --group_reporting --fallocate=none --name=A13_3 >> $RESULT &

		#umount -l /mnt/A13_0
		#umount -l /mnt/A13_1
		#umount -l /mnt/A13_2
		#umount -l /mnt/A13_3
	
	fi

#------------------------------------------------
END


	sleep 1
done
