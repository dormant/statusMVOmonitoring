#!/usr/bin/bash
# 
# Runs sniffwave to capture all data details and outputs to a named pipe
# Must run on winston1
#
# R.C. Stewart, 2024-02-07

today=$(date -u +"%Y%m%d")
host=`hostname -s`

# Check if earthworm is running

. ./scriptVariables.txt

# Named pipe
pipe=/tmp/sniffpipe

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi


source /home/wwsuser/earthworm/run_mvo/params/ew_linux.bash

cd /home/wwsuser/src/statusMVOmonitoring/scripts

pkill sniffwave

nohup sniffwave WAVE_RING wild wild wild wild n > $sniffpipe &
