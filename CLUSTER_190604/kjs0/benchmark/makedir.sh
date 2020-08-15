#!/bin/bash


for ((i=0;i<=3;i++));
do
	for ((j=0;j<=13;j++));
	do
		dirname="/mnt/A${j}_${i}"
		echo $dirname
		mkdir $dirname
	done
done

for ((i=0;i<=3;i++));
do
	for ((j=0;j<=13;j++));
	do
		dirname="/mnt/B${j}_${i}"
		echo $dirname
		mkdir $dirname
	done
done

for ((i=0;i<=3;i++));
do
	for ((j=0;j<=13;j++));
	do
		dirname="/mnt/C${j}_${i}"
		echo $dirname
		mkdir $dirname
	done
done

