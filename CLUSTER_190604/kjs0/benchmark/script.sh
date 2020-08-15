#!/bin/bash

killall -9 ./monitor
sh /home/dcslab/glusterfs/restart_server.sh
