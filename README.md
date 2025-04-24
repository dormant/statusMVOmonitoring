# statusMVOmonitoring

Scripts to monitor the MVO seismic data acquisition system.

## wws_data_availability

* Scripts to calculate and plot the daily availability of data on the Winston waveserver.
* *wws_da.sh* runs as a cronjob once a day, just after midnight UTC, on *opsproc3*.


## wws_latency

* Scripts to calculate and plot the latency of data on the Winston waveserver.
* Run as cronjobs on *opsproc3*.
* Latency can only be calculated to an accuracy of one second.
* Results stored in */mnt/mvofls2/Seismic_Data/monitoring_data/status/latencyWWS*.
* Results can be seen in *notWebobs*.


## Author

Roderick Stewart, Dormant Services Ltd

rod@dormant.org

https://services.dormant.org/

## Version History

* 1.0-dev
    * Working version

## License

This project is the property of Montserrat Volcano Observatory.
