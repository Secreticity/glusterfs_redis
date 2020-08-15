#!/bin/bash

fio --directory=/mnt/padu0 --name=123 --fsync=0 --rw=write --direct=1 --bs=1M --size=10G --numjobs=16 --group_reporting --ioengine=sync --fallocate=none &
fio --directory=/mnt/padu1 --name=456 --fsync=0 --rw=write --direct=1 --bs=1M --size=10G --numjobs=16 --group_reporting --ioengine=sync --fallocate=none &
fio --directory=/mnt/padu2 --name=789 --fsync=0 --rw=write --direct=1 --bs=1M --size=10G --numjobs=16 --group_reporting --ioengine=sync --fallocate=none &
fio --directory=/mnt/padu3 --name=101112 --fsync=0 --rw=write --direct=1 --bs=1M --size=10G --numjobs=16 --group_reporting --ioengine=sync --fallocate=none &

