# statusMVOmonitoring

Monitoring the MVO seismic data acquisition system.

## Description

The directory *~/data/statusMVOmonitoring* should be present on all Linux computers using in MVO seismic monitoring.

All files should be the same, except for those in the following subdirectories.
* data
* logs
* plots
* reports
* spreadsheets

The contents of *data* are regularly synchronised one-way using rsync to */mnt/mvofls2/Seismic_Data/monitoring_data/status*.
```
*/5 * * * * /usr/bin/rsync -a /home/wwsuser/data/statusMVOmonitoring/data/ /mnt/mvofls2/Seismic_Data/monitoring_data/status >/dev/null 2>&1
22 0 1 * * /usr/bin/find /home/wwsuser/data/statusMVOmonitoring/data -type f -name '*.txt' -mtime +28 -exec rm -f {} \; > /dev/null 2>&1
```
The data is accessible through *notWebobs*: http://webobs.mvo.ms:8080/.


## src

### data_availability_wws

* Scripts to calculate and plot the daily availability of data on the Winston waveserver.
* *wws_da.sh* runs as a cronjob once a day, just after midnight UTC, on *opsproc3*.
* Results stored in */mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws*.
* Results can be seen in *notWebobs*.


### data_latency_wws

* Scripts to calculate and plot the latency of data on the Winston waveserver.
* Run as cronjobs on *opsproc3*.
* Latency can only be calculated to an accuracy of one second.
* Results stored in */mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws*.
* Results can be seen in *notWebobs*.

### earthworm

* Scripts to monitor earthworm on a Linux computer.
* Most run as cronjobs.

#### earthworm_status.pl

* Runs earthworm program *status* and saves output in file.
* Runs as cronjob by user *wwsuser* on every 5 minutes.
```
# earthworm status
*/5 * * * * /home/wwsuser/data/statusMVOmonitoring/src/earthworm/earthworm_status.pl > /mnt/mvofls2/Seismic_Data/monitoring_data/status/earthworm/status-winston1.txt 2>&1
```

#### getSniffwave.sh

* Runs earthworm program *sniffwave* and stores output in daily text files.
* Used to calculate data availability and latency.
* Runs as cronjob by user *wwsuser* every day and at boot.
```
# statusMVOmonitoring
0 0 * * * /home/wwsuser/data/statusMVOmonitoring/src/earthworm/getSniffwave.sh > /dev/null 2&>1

@reboot /home/wwsuser/data/statusMVOmonitoring/src/earthworm/getSniffwave.sh > /dev/null 2&>1
```

#### scriptVariables.txt

* Common variables for bash scripts

### radian_log_files

#### radianLogFilesFetch.pl

* Copies log files from all Radian stations.
* IP addresses are in script.
* Runs once a week (Thursday) as a cronjob on *opsproc3*.
* Log files stored in */mnt/mvofls2/Seismic_Data/monitoring_data/status/seismic_stations/radian_log_files*.
* MBLG removed from script as slow connection caused crashes.

#### radianLogFilesCheckTime.pl, radianLogFilesPlotTime.m

* Checks time stamps in Radian log files.
* Was used when MBFL was losing time at times every day.
```
$ ./radianLogFilesCheckTime.pl > MBFL-noClock.txt
```
* Matlab script *radianLogFilesPlotTime.m* plots the results.

## Author

Roderick Stewart, Dormant Services Ltd

rod@dormant.org

https://services.dormant.org/

## Version History

* 1.0-dev
    * Working version

## License

This project is the property of Montserrat Volcano Observatory.
