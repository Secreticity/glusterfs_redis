#!/bin/bash

df -h $1 | awk '{ print $3 }' | tail -n 1
