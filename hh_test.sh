#!/bin/bash

#prg=(1 3 4 5 6 7 8 10 12 13 15 17 18 19 20 21 22 24 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
#mul=(3 5 1 10 250 50 30 70 250 500 800 3 700 100 150 150 2 170 60 15 3 2 106 1 3 1 140 3 100 2 3 2)

#prg=(1 3 5 8 12 13 17 18 19 20 22 24 27 28 29 30 31 32 33 34 35 38 40)
#mul=(3 5 10 30 250 500 3 700 100 150 2 170 60 15 3 2 106 1 3 1 140 2 2)

prg=(17 18 19 20 30 35)
mul=(3 700 100 150 1000 800)


SET=$(seq 0 10)
for i in $SET
do
	echo "=====================i:$i"
	(cd /mnt/jw$((i*4)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4))) &
	(cd /mnt/jw$((i*4+1)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4+1))) &
	(cd /mnt/jw$((i*4+2)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4+2))) &
	(cd /mnt/jw$((i*4+3)) && exec /home/dcslab/0522again_replayer /home/dcslab/data/NERSC_data/io_traces/${prg[$(($i%6))]}/logs. ${mul[$(($i%6))]} $((i*4+3)))
	
	#echo "finish"
	

	#echo ${prg[$(($i%6))]}
	#echo ${mul[$(($i%6))]} 
done
