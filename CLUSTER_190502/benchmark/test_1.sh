#!/bin/bash

SRC_DIR="/mnt/padu1"
DES_DIR="/mnt/cold"

for FILE in $(ls -1 ${SRC_DIR} | grep ${1}); do
	/home/dcslab/benchmark/sendfile_benchmark ${SRC_DIR}/${FILE} ${DES_DIR}/${FILE}
	#/home/dcslab/benchmark/splice_benchmark ${SRC_DIR}/${FILE} ${DES_DIR}/${FILE}
	#mv ${SRC_DIR}/${FILE} ${DES_DIR}/${FILE}
	echo "${FILE}"
done
