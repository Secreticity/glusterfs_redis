#!/bin/bash


COUNT=$1
TIME=$2

tmp=1
sum=0
sum2=0
declare -a rand

while [ "$tmp" -le $COUNT ];
do
	rand[$tmp]=$(($RANDOM%1000))
	let "sum += ${rand[$tmp]}"
	let "tmp += 1"
done
echo "${rand[*]}"
echo "$sum"


tmp=1
while [ "$tmp" -le $COUNT ];
do
	rand[$tmp]=$(echo "scale=4; ${rand[$tmp]} / $sum" | bc -l)
	rand[$tmp]=$(echo "scale=4; ${rand[$tmp]} * $TIME" | bc -l)
	#rand[$tmp]=$(bc <<< "scale=2; ${rand[$tmp]} / $sum")
	#rand[$tmp]=$(bc <<< "scale=2; ${rand[$tmp]} * $TIME")
	#rand[$tmp]=$((echo $(printf %.0f %{rand[$tmp]})))
	#rand[$tmp]=${rand[$tmp]%.*}

	sum2=$(echo "$sum2 + ${rand[$tmp]}" | bc -l)
	#sum2=$(bc <<< "scale=2; $sum2 + ${rand[$tmp]}")
	#echo $sum2
	#let "sum2 += ${rand[$tmp]}"
	
	echo "sleep for ${rand[$tmp]} seconds"
	sleep ${rand[$tmp]}

	let "tmp += 1"
done
echo "${rand[*]}"
echo "$sum2"

