#!/bin/bash


#mount -t cgroup -o blkio none /sys/fs/cgroup/blkio

#cat /proc/partitions
#for nvme1n1
TMP=$(cat /proc/partitions | awk '/nvme4n1/ { print $2}')
echo "259:$TMP $(bc <<< ${1}*1024*1024)" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
