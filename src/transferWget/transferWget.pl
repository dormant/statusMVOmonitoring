#!/usr/bin/perl
#
# Tests data transfer rate from seismic stations using wget
# 
# R.C. Stewart, 2024-01-22

use strict;
use warnings;
use Net::Ping;
use Time::Local;

chomp(my $hostname = `hostname -s`);

my $dirData = "../../data";
my $dirConfig = "../../config";

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Get todays date and time (UTC)
#
my ($year, $month, $day) = (gmtime())[5,4,3];
$year = 1900 + $year;
$month++;
my $fileDate = sprintf( '%04s%02s%02s', $year, $month, $day );

my $fileStations = join( '/', $dirConfig, 'stations.txt' );
open my $if, $fileStations or die "Cant open $fileStations: $!";

while( my $line = <$if> ) {

    my ($sta, $ip, $type) = split /\s+/, $line;

    if( substr( $sta, 0, 1 ) ne "#" ) {

        print $sta, " ";

        my $dirDataFull = join( '/', $dirData, "transferWget", $sta );
        mkdir $dirDataFull unless -d $dirDataFull;
        my $fileData = join( '.', $fileDate, $hostname, $ip, 'txt' );
        $fileData = join( '/', $dirDataFull, $fileData );

        my $cmd;
        if( $type eq "radian" ) {
            $cmd = join( '', 'wget --connect-timeout=30 --read-timeout=120 http://', $ip, '/sd/init.log 2>&1 | grep saved' );
        } elsif( $type eq "eam" ) {
            $cmd = join( '', 'wget --user root --password rootme --connect-timeout=30 --read-timeout=120 http://', $ip, '/cgi-bin/auth-frameset.cgi 2>&1 | grep saved' );
        }

        my $rightNow = timegm(gmtime);
        my $count;
        my $units;

        my $p = Net::Ping->new();
        if( $p->ping( $ip ) ){
            print "pingable\n";
            my $wgot = `$cmd`;
            chomp $wgot;
            $wgot =~ s/.+?\((.+?)\).*/$1/;
            ($count, $units) = split /\s/, $wgot;
            if( $units eq "MB/s" ) {
                $count = $count;
            } elsif( $units eq "KB/s" ) {
                $count = $count/1024;
            } else {
                $count = "NaN";
            }
        } else {
            print "unpingable\n";
            $count = "NaN";
        }
        $p->close();

        open( OUT, ">>$fileData" ) or die "Cant open $fileData: $!";
        printf OUT "%d %8.4f\n", $rightNow, $count;
        close( OUT );

        system( "rm init.log" );

    }


}

close $if;

