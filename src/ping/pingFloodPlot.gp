#!/usr/bin/gnuplot -c

# plot_wws_latency.gp
#
# plots pingFlood data
#
# R.C. Stewart, 2024-02-08

#set terminal qt

hours = 0.5
xbeg = strftime("%s", time(0)-hours*60*60)
xend = strftime("%s", time(0))


set terminal png size 2400,1600 font "Arial,18"
set output '../../plots/fig-pingFlood.png'

set key left top box



set yrange [0:] 
set xdata time
set timefmt "%s"
set xrange [xbeg:xend]

set style data points

set grid xtics

set multiplot layout 8,1 title "pingFlood ping times from opsproc3 (ms)"

set format x ""
set lmargin at screen 0.05
plot "../../data/pingFlood/earthworm03-172.17.102.62-opsproc3.txt" using 1:2 with points pt 5 title "earthworm3"
plot "../../data/pingFlood/mvocobweb1-172.17.102.68-opsproc3.txt" using 1:2 with points pt 5 title "mvocobweb1"
plot "../../data/pingFlood/mvofls2-172.17.102.66-opsproc3.txt" using 1:2 with points pt 5 title "mvofls2"
plot "../../data/pingFlood/mvoscream3-172.17.102.64-opsproc3.txt" using 1:2 with points pt 5 title "mvoscream3"
plot "../../data/pingFlood/winston1-172.17.102.60-opsproc3.txt" using 1:2 with points pt 5 title "winston1"
plot "../../data/pingFlood/webobs-172.17.117.1-opsproc3.txt" using 1:2 with points pt 5 title "webobs"
set xlabel "Time (UTC)"
#set format x "%d/%m\n%H:%M"
#set format x "%H:%M"
#plot "../../data/pingFlood/google-8.8.8.8-opsproc3.txt" using 1:2 with points pt 5 title "google"

set timestamp "%Y-%m-%d %H:%M UTC" font ",10"
