#!/bin/bash


#mount -t cgroup -o blkio none /sys/fs/cgroup/blkio

#cat /proc/partitions
#for nvme1n1a
TMP=$(cat /proc/partitions | awk '/nvme2n1/ { print $2}')
echo "259:$TMP $(bc <<< ${1}*1024*1024)" > /sys/fs/cgroup/blkio/blkio.throttle.read_bps_device
