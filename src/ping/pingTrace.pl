#!/usr/bin/perl
#
# Does a ping and a traceroute on every station
# 
# R.C. Stewart, 2024-01-25

use strict;
use warnings;
use Net::Ping;
use Time::Local;

chomp(my $hostname = `hostname -s`);

my $dirData = "../../data";
my $dirConfig = "../../config";

my $fileStations = join( '/', $dirConfig, 'stations.txt' );
open my $if, $fileStations or die "Cant open $fileStations: $!";

while( my $line = <$if> ) {

    my ($sta, $ip, $type, $cha) = split /\s+/, $line;

    if( substr( $sta, 0, 1 ) ne "#" ) {

        my $rightNow = timegm(gmtime);
        print "$sta\n";

        if( $ip ne "none" ){
            my $cmd = join( " ", "ping -c 5", $ip, "| grep packet" );
            system( $cmd );

            $cmd = join( " ", "traceroute", $ip );
            system( $cmd );
        } else {
            print "Not pingable\n";
        }

        print "\n";

    }

}

close $if;

