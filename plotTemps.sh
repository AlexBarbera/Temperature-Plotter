#! /bin/bash

pid=$1
w_time=$2

maxT=`sensors | grep Core | rev | cut -d" " -f1 | cut -c5- | rev | cut -c2- | head -n1`

temp_file="temp.dat"

n=`sensors | grep Core | wc -l`
n=$[n-2]

for i in `seq 0 $n`; do
echo -n "Core $i," >> $temp_file
done

n=$[n+1]

echo "Core $n" >> $temp_file

while kill -0 $pid 2> /dev/null; do
# processors
sensors | grep Core | cut -d" " -f10 | cut -c2- | rev | cut -c4- | rev | tr "\n" "," | rev | cut -c2- | rev >> $temp_file

sleep $w_time
done

gnuplot -e " \"file='$temp_file; time='$w_time'; output='$pid.png'\" gnuplot.gp"

#query="plot \"$temp_file\" u0:1 w lp"

#for i in `seq 2 $[n+1]`; do
#query="$query, \"$temp_file\" u0:$i w lp"
#done
