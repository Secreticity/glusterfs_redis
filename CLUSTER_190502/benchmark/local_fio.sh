#!/bin/bash

fio --directory=/mnt/padu0 --fsync=0 --rw=write --direct=1 --bs=1M --size=5G --numjobs=10 --group_reporting --name=fiotwo &
fio --directory=/mnt/padu1 --fsync=0 --rw=write --direct=1 --bs=1M --size=5G --numjobs=10 --group_reporting --name=fiotwo &
fio --directory=/mnt/padu2 --fsync=0 --rw=write --direct=1 --bs=1M --size=5G --numjobs=10 --group_reporting --name=fiotwo &
fio --directory=/mnt/padu3 --fsync=0 --rw=write --direct=1 --bs=1M --size=5G --numjobs=10 --group_reporting --name=fiotwo &
