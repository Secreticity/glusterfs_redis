#!/bin/bash

taskset -c 2 ./test.sh AAA &
taskset -c 3 ./test.sh BBB &
#taskset -c 4 ./test.sh CCC &
#taskset -c 5 ./test.sh DDD &
#taskset -c 6 ./test.sh EEE &






:<<"END"
taskset -c 41 ./test.sh aa &
taskset -c 40 ./test.sh ccc &
taskset -c 39 ./test.sh ddd &
taskset -c 38 ./test.sh eee &
taskset -c 37 ./test.sh sss &
taskset -c 36 ./test.sh ggg &
taskset -c 35 ./test.sh zzz &
taskset -c 34 ./test.sh fff &
taskset -c 33 ./test.sh hhh &
taskset -c 32 ./test.sh iii &
taskset -c 31 ./test_1.sh aa &
taskset -c 30 ./test_1.sh ccc &
taskset -c 29 ./test_1.sh ddd &
taskset -c 28 ./test_1.sh eee &
taskset -c 27 ./test_1.sh sss &
taskset -c 26 ./test_1.sh ggg &
taskset -c 25 ./test_1.sh zzz &
taskset -c 24 ./test_1.sh fff &
taskset -c 23 ./test_1.sh hhh &
taskset -c 22 ./test_1.sh iii &
taskset -c 21 ./test_2.sh aa &
taskset -c 20 ./test_2.sh ccc &
taskset -c 19 ./test_2.sh ddd &
taskset -c 18 ./test_2.sh eee &
taskset -c 17 ./test_2.sh sss &
taskset -c 16 ./test_2.sh ggg &
taskset -c 15 ./test_2.sh zzz &
taskset -c 14 ./test_2.sh fff &
taskset -c 13 ./test_2.sh hhh &
taskset -c 12 ./test_2.sh iii &
taskset -c 11 ./test_3.sh aa &
taskset -c 10 ./test_3.sh ccc &
taskset -c 9 ./test_3.sh ddd &
taskset -c 8 ./test_3.sh eee &
taskset -c 7 ./test_3.sh sss &
taskset -c 6 ./test_3.sh ggg &
taskset -c 5 ./test_3.sh zzz &
taskset -c 4 ./test_3.sh fff &
taskset -c 3 ./test_3.sh hhh &
taskset -c 2 ./test_3.sh iii &
END
