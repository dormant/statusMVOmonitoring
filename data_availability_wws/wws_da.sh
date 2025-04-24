#!/usr/bin/bash
#
# Gets data availability and gaps from winston wave server
# Should be run as a cron job just after midnight UTC
#
# R.C. Stewart, 19-Feb-2021

datadate=`date -d "yesterday" '+%Y%m%d'`

/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBBY_HHZ_MV_00&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBBY-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBFL_HHZ_MV_00&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBFL-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBFR_HHZ_MV_00&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBFR-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBGB_HHZ_MV_00&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBGB-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBGH_HHZ_MV_00&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBGH-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBHA_SHZ_MV_--&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBHA-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBLG_HHZ_MV_00&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBLG-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBLY_HHZ_MV_00&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBLY-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBRV_BHZ_MV_--&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBRV-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBRY_BHZ_MV_--&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBRY-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MBWH_BHZ_MV_--&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MBWH-'${datadate}'.html'
/usr/bin/curl -s "http://172.17.102.60:16022/gaps?code=MSS1_SHZ_MV_--&t1=-24" > '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/MSS1-'${datadate}'.html'


cd /home/seisan/src/statusMVOmonitoring/data_availability_wws
./wws_da_proc.pl
/usr/local/bin/matlab -nosplash -nodisplay -nodesktop < wws_da_plot.m >/dev/null

times
