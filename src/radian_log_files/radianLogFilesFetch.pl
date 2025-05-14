#!/usr/bin/perl
#
# Fetches all Radian log files
#
# R.C. Stewart 15-Feb-2023
#

use strict;
use warnings;

use DateTime;
use Net::Ping;
use File::Fetch;
use File::Copy qw(move);

my $dt = DateTime->now;
my $datestr = $dt->ymd('');

my $pinger = Net::Ping->new();

my $dirRadianLogs = '/mnt/mvofls2/Seismic_Data/monitoring_data/status/seismic_stations/radian_log_files';

#my @stations = ( 'MBBY', 'MBFL', 'MBFR', 'MBGB', 'MBGH', 'MBLG', 'MBLY', 'MBWH' );
#my @ips = ( '172.17.102.20', '172.17.102.21', '172.17.102.22', '172.17.102.23', '172.17.102.24', '172.30.0.79', '172.17.102.27', '172.17.102.25' );
my @stations = ( 'MBBY', 'MBFL', 'MBFR', 'MBGB', 'MBGH', 'MBLY', 'MBWH' );
my @ips = ( '172.17.102.20', '172.17.102.21', '172.17.102.22', '172.17.102.23', '172.17.102.24', '172.17.102.27', '172.17.102.25' );

my $nsta = scalar( @stations );

print $dt, "\n";

for my $ista (0..$nsta-1){

	print $stations[$ista], " ";
    if ($pinger->ping($ips[$ista])) {
        print "pingable\n";

        my $sttime = DateTime->now;
        foreach( 'status', 'system', 'init' ) {
            my $logFileTmp = join( '.', $_, 'log' );
            my $url = 'http://' . $ips[$ista] . '/sd/' . $logFileTmp;
            my $logFile = join( '-', $stations[$ista], $ips[$ista], $datestr, $logFileTmp );
            print " fetching $url to $logFile\n";
            my $ff = File::Fetch->new(uri => $url);
            my $file = $ff->fetch() or die $ff->error;
            $logFile = join( '/', $dirRadianLogs, $logFile );
            move $logFileTmp, $logFile;
        }
        my $entime = DateTime->now;
        my $elapse = $entime - $sttime;
        print " elapsed time : ".$elapse->in_units('seconds')."s\n";

    } else {
        print "not pingable\n";
    }
	
}

my $entime = DateTime->now;
my $elapse = $entime - $dt;
print "total elapsed time : " . sprintf( "%02dh %02dm %02ds", $elapse->in_units('hours','minutes','seconds') , "\n");
print "\n";

