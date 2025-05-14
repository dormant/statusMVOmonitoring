#!/usr/bin/bash

./plot_wws_latency.gp 3
rename 's/\.png/\-3\.png/g' *.png
mv *.png /mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/

./plot_wws_latency.gp 12
rename 's/\.png/\-12\.png/g' *.png
mv *.png /mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/

./plot_wws_latency.gp 72 
rename 's/\.png/\-72\.png/g' *.png
mv *.png /mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws/

