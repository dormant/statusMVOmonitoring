# statusMVOmonitoring

## ~/data/statusMVOmonitoring

Monitoring the MVO seismic data acquisition system.

## Description

The directory *~/data/statusMVOmonitoring* should be present on all Linux computers using in MVO seismic monitoring.

The following subdirectories should be present and identical on all the computers.

* config
* src

The following subdirectories should be present on all the computers, but the contents will differ.
* data
* logs
* plots

The following subdirectories are currently only on *opsproc3*.
* reports
* specificProblems
* spreadsheets
* tests

The contents of *data* on all the computers are regularly synchronised one-way using rsync to */mnt/mvofls2/Seismic_Data/monitoring_data/status*.
```
*/5 * * * * /usr/bin/rsync -a /home/wwsuser/data/statusMVOmonitoring/data/ /mnt/mvofls2/Seismic_Data/monitoring_data/status >/dev/null 2>&1
22 0 1 * * /usr/bin/find /home/wwsuser/data/statusMVOmonitoring/data -type f -name '*.txt' -mtime +28 -exec rm -f {} \; > /dev/null 2>&1
```
The data is accessible through *notWebobs*: http://webobs.mvo.ms:8080/.


## src/data_availability_wws

* Scripts to calculate and plot the daily availability of data on the Winston waveserver.
* *wws_da.sh* runs as a cronjob once a day, just after midnight UTC, on *opsproc3*.
* Results stored in */mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws*.
* Results can be seen in *notWebobs*.


## src/data_latency_wws

* Scripts to calculate and plot the latency of data on the Winston waveserver.
* Run as cronjobs on *opsproc3*.
* Latency can only be calculated to an accuracy of one second.
* Results stored in */mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws*.
* Results can be seen in *notWebobs*.

## src/earthworm

* Scripts to monitor earthworm on a Linux computer.
* Most run as cronjobs.

### earthworm_status.pl

* Runs earthworm program *status* and saves output in a text file.
* Runs as cronjob by user *wwsuser* on every 5 minutes.
```
# earthworm status
*/5 * * * * /home/wwsuser/data/statusMVOmonitoring/src/earthworm/earthworm_status.pl > /mnt/mvofls2/Seismic_Data/monitoring_data/status/earthworm/status-winston1.txt 2>&1
```

### extractSniffwave.pl

* Calculates data latency from sniffwave data.
* Runs once a day as cronjob on *opsproc3*.
```
40 1 * * * cd /home/seisan/data/statusMVOmonitoring/src/earthworm; ./extractSniffwave.pl >/home/seisan/data/statusMVOmonitoring/logs/extractSniffwave.log 2>&1
```

### extractSniffwave2.m

* Calculates data transfer rate from sniffwave data.
* Results stored in *data/data_transfer_sniffwave*.
* Runs once a day as cronjob on *opsproc3*.
```
40 2 * * * /usr/local/bin/matlab -sd /home/seisan/data/statusMVOmonitoring/src/earthworm -batch extractSniffwave2 > /home/seisan/data/statusMVOmonitoring/logs/extractSniffwave2.log 2>&1
```


### getSniffwave.sh

* Runs earthworm program *sniffwave* and stores output in daily text files.
* Used to calculate data availability and latency.
* Runs as cronjob by user *wwsuser* every day and at boot.
```
# statusMVOmonitoring
0 0 * * * /home/wwsuser/data/statusMVOmonitoring/src/earthworm/getSniffwave.sh > /dev/null 2&>1

@reboot /home/wwsuser/data/statusMVOmonitoring/src/earthworm/getSniffwave.sh > /dev/null 2&>1
```

### scriptVariables.txt

* Common variables for bash scripts


## src/ping

* Test network using *ping*.
* Use sparingly as it clogs the network.

### pingFlood.pl

* Runs *ping* intensely in the background for all machines listed in *config/servers.txt*.
* Stop using
```
$ pkill ping
```

### pingFloodPlot.gp, pingFloodPlot.m

* *Gnuplot* and *MATLAB* scripts to plot results of *pingFlood.pl*.
* Run from command line, edited as needed.

### pingTrace.pl

* Runs *ping* and *traceroute* for all stations listed in *config/stations.txt*.
* Run from command line.

## src/radian_log_files

### radianLogFilesFetch.pl

* Copies log files from all Radian stations.
* IP addresses are in script.
* Log files stored in */mnt/mvofls2/Seismic_Data/monitoring_data/status/seismic_stations/radian_log_files*.
* MBLG removed from script as slow connection caused crashes.
* Runs once a week (Thursday) as a cronjob on *opsproc3*.
```
# Fetch log files from Radian stations
30 8 * * Thu /home/seisan/data/statusMVOmonitoring/src/radian_log_files/radianLogFilesFetch.pl >> /home/seisan/data/statusMVOmonitoring/logs/radianLogFilesFetch.log 2>&1
```

### radianLogFilesCheckTime.pl, radianLogFilesPlotTime.m

* Checks time stamps in Radian log files.
* Was used when MBFL was losing time at times every day.
```
$ ./radianLogFilesCheckTime.pl > MBFL-noClock.txt
```
* *MATLAB* script *radianLogFilesPlotTime.m* plots the results.

## src/scripts

Various scripts used ...

## src/transferWget

* Scripts to test and plot data transfer rates from stations using *wget*.
* Results are stored in *data/transferWget*.
* Run once an hour as a cron job on *opsproc3*.
```
10 * * * * cd /home/seisan/data/statusMVOmonitoring/src/transferWget; ./transferWget.pl >/dev/null 2>&1; rm init.log*
15 * * * * cd /home/seisan/data/statusMVOmonitoring/src/transferWget; ./transferWgetMerge.sh >/dev/null 2>&1
```

## spreadsheets/systemNotes.xlsx

This spreadsheet notes any problems with stations, computers and infrastructure involved in seismic monitoring at MVO. 

* Dates and times are recorded using the *yyyymmdd-hhmm* format.
* Outages less than one hour are not included.
* There is one sheet for each station.
* Things that affect the whole system, or non-station assets, are recorded in the *System* sheet.
* Changes made in data-acquisition software are recorded in the *Actions* sheet.
* Information is extracted from this spreadsheet once an hour by a cronjob on *opsproc3*. 
```
54 * * * * /home/seisan/data/statusMVOmonitoring/src/scripts/systemNotesExtract.pl > /home/seisan/data/statusMVOmonitoring/reports/systemNotesExtract/currentProblems.txt
55 * * * * /home/seisan/data/statusMVOmonitoring/src/scripts/systemNotesExtract.pl all > /home/seisan/data/statusMVOmonitoring/reports/systemNotesExtract/allProblemsByStation.txt
56 * * * * /home/seisan/data/statusMVOmonitoring/src/scripts/systemNotesExtract.pl chron > /home/seisan/data/statusMVOmonitoring/reports/systemNotesExtract/allProblemsChronologically.txt
```


## Author

Roderick Stewart, Dormant Services Ltd

rod@dormant.org

https://services.dormant.org/

## Version History

* 1.0-dev
    * Working version

## License

This project is the property of Montserrat Volcano Observatory.
