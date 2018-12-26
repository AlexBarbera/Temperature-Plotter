set datafile separator ","
set xlabel "Timestamp (".time." s intervals)"
set ylabel "Temp ºC"
set title "Core temperatures for PID ".output
set term png
set output output

stats file skip 1
colnum = STATS_columns

plot for [col=1:colnum] file using 0:col w lp title columnheader(col)

