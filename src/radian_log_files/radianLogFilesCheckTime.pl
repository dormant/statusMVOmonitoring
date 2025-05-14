#!/usr/bin/perl
#
# Checks time stamps in Radian log files
#
# R.C. Stewart 15-Feb-2023
#

use strict;
use warnings;
use DateTime;
use DateTime::Format::ISO8601;

my $dirRadianLogs = '/mnt/mvofls2/Seismic_Data/monitoring_data/status/seismic_stations/radian_log_files';

my @files = glob( $dirRadianLogs . '/' . 'MBFL*system*.log' );

for my $file (@files) {
    #print $file, "\n";

    open( FILE, $file )  or die "Could not open $file: $!";

    my $datim;
    my $datimPrevious = '1995-07-01T00:00:00.000Z';
    while( my $line = <FILE>)  {
        chomp $line;
        $datim = substr $line, 0, 24;
        if( substr( $datimPrevious, -1 ) eq 'Z' && substr( $datim, -1 ) eq 'Z' ){
            my $dt1 = DateTime::Format::ISO8601->parse_datetime( $datimPrevious );
            my $dt2 = DateTime::Format::ISO8601->parse_datetime( $datim);
            my $dtDiff = $dt2->epoch - $dt1->epoch;
            if( abs( $dtDiff ) > 100000000 ){
                #print "$datimPrevious  $datim  $dtDiff\n";
                #print "$datimPrevious jumped to $datim \n";
                if( substr( $datimPrevious, 0, 3 ) eq '202' ){
                    print "$datimPrevious  -  ";
                }
                if( substr( $datim, 0, 3 ) eq '202' ){
                    print "$datim\n";
                }
            }
            $datimPrevious = $datim;
        }
    }

    close FILE;
}

