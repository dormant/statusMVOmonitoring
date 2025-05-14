#!/usr/bin/gnuplot -c

# plot_data_latency_wws.gp
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

set output 'fig-data_latency_wws-MBFL.png'
set title ARG2.'MBFL WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBFL.HHZ.MV.00.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBFR.png'
set title ARG2.'MBFR WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBFR.HHZ.MV.00.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBGB.png'
set title ARG2.'MBGB WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBGB.HHZ.MV.00.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBGH.png'
set title ARG2.'MBGH WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBGH.HHZ.MV.00.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBHA.png'
set title ARG2.'MBHA WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBHA.SHZ.MV.--.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBLG.png'
set title ARG2.'MBLG WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBLG.HHZ.MV.00.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBLY.png'
set title ARG2.'MBLY WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBLY.HHZ.MV.00.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBRV.png'
set title ARG2.'MBRV WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBRV.BHZ.MV.--.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBRY.png'
set title ARG2.'MBRY WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBRY.BHZ.MV.--.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MBWH.png'
set title ARG2.'MBWH WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MBWH.BHZ.MV.--.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

set output 'fig-data_latency_wws-MSS1.png'
set title ARG2.'MSS1 WWS winston1 data latency (last '.hours.' hours)'
set nokey
plot '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/MSS1.SHZ.MV.--.-winston1-data_latency_wws.txt' using ($1):2 with points pointtype 6 ps 1 lc rgb "red"

