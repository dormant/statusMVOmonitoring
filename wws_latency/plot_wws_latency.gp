#!/usr/bin/gnuplot -c

# plot_latencyWWS.gp
#
# plots data latency, argument gives hours of plot
#
# R.C. Stewart, 4-Jul-2022

#set terminal qt

hours=ARG1


xbeg = strftime("%s", time(0)-hours*60*60)
xend = strftime("%s", time(0))


set terminal png size 1200,800 font "Arial,18"

set key center top box


set timestamp "%Y-%m-%d %H:%M UTC" font ",10"

set xlabel "Time of request"
set ylabel "Data latency (integer seconds)"
set yrange [0:] 
set xdata time
set timefmt "%s"
set xrange [xbeg:xend]
set format x "%d/%m\n%H:%M"

set label 3 "WARNING: This plot shows\nthe latest data available on\nthe waveserver at the time of\nasking, so is not true latency.\n\nBeware upgoing lines." at xbeg,0 left offset 1,24

set output 'fig-latencyWWS-MBFL.png'
set title ARG2.'MBFL WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBFL.HHZ.MV.00.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBFR.png'
set title ARG2.'MBFR WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBFR.HHZ.MV.00.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBGB.png'
set title ARG2.'MBGB WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBGB.HHZ.MV.00.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBGH.png'
set title ARG2.'MBGH WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBGH.HHZ.MV.00.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBHA.png'
set title ARG2.'MBHA WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBHA.SHZ.MV.--.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBLG.png'
set title ARG2.'MBLG WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBLG.HHZ.MV.00.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBLY.png'
set title ARG2.'MBLY WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBLY.HHZ.MV.00.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBRV.png'
set title ARG2.'MBRV WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBRV.BHZ.MV.--.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBRY.png'
set title ARG2.'MBRY WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBRY.BHZ.MV.--.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MBWH.png'
set title ARG2.'MBWH WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MBWH.BHZ.MV.--.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-latencyWWS-MSS1.png'
set title ARG2.'MSS1 WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS/MSS1.SHZ.MV.--.-winston1-latencyWWS.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

