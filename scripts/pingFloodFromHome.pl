#!/usr/bin/perl
#
# Does a flood of pings on certain machines
# Version to run from home
# 
# R.C. Stewart, 2024-02-08

use strict;
use warnings;
use Net::Ping;
use Time::Local;

system( 'pkill \'^ping$\'' );

chomp(my $hostname = `hostname -s`);
my $dirData = "../data";
my $dirConfig = "../config";

my $rightNow = timegm(gmtime);
my ($year, $month, $day, $hour, $minute) = (gmtime($rightNow))[5,4,3,2,1];
$year = 1900 + $year;
$month++;
my $fileDate = sprintf( '%04s%02s%02s-%02s%02s', $year, $month, $day, $hour, $minute );

my $fileMachines = join( '/', $dirConfig, 'internet.txt' );
open my $if, $fileMachines or die "Cant open $fileMachines $!";

while( my $line = <$if> ) {

    my ($machine, $ip) = split /\s+/, $line;

    if( substr( $machine, 0, 1 ) ne "#" ) {

        if( $ip ne "none" ){

            my $filePing = join( "-", $machine, $ip, $hostname );
            $filePing = join( ".", $filePing, "txt" );
            $filePing = join( "/", $dirData, "pingFlood", $filePing );
            my $pingArgs = "-D -i 1.0";
            $pingArgs = "-D";
            my $cmd = join( " ", "ping", $pingArgs, $ip, '| grep -v \'^PING\' | awk \'{print $1 $8}\' | sed -u \'s/[][]//g\' | sed -u \'s/time=/  /\'', ">", $filePing, "&" );
            print $cmd, "\n";
            system( $cmd );

        }

    }

}

close $if;

