#!/usr/bin/perl
#
# Checks for missing SEISAN data files
#
# R.C. Stewart 2024-08-27
#

use strict;
use warnings;
use DateTime;
use DateTime::Format::ISO8601;
use Time::DaysInMonth;

my @dirsSeisanCont = ( '/mnt/mvohvs3/MVOSeisD6/WAV/DSNC_', '/mnt/mvofls2/Seismic_Data/WAV/DSNC_' );
for my $dirSeisanCont (@dirsSeisanCont) {

    my @dirsYear = grep {-d} glob "$dirSeisanCont/*";
    for my $dirYear (@dirsYear) {
        if( $dirYear =~ /DSNC_\/[12]/ ){

            my $year4 = substr( $dirYear, -4 );
            my $year2 = substr( $dirYear, -2 );

            my @dirsMonth = grep {-d} glob "$dirYear/*";
            for my $dirMonth (@dirsMonth) {
                if( $dirMonth =~ /\d\d$/ ){

                    my $month = substr( $dirMonth, -2 );

                    my $daysInMonth = days_in($year4, $month);
                    my $nFilesExpected = $daysInMonth * 24 *3;

                    opendir(my $dh, $dirMonth) || die "Can't opendir $dirMonth $!";
                    my @files = readdir($dh);
                    closedir $dh;
                    my $nFiles = scalar @files;
                    my $nFilesY = scalar ( grep { /^\d/ } @files );
                    my $nFilesYBz2 = scalar ( grep { /^\d.*bz2$/ } @files );
                    my $nFilesYY = scalar ( grep { /^$year2/ } @files );
                    my $nFilesYYYY = scalar ( grep { /^$year4/ } @files );

                    my $match = '';
                    if( $nFilesY != $nFilesExpected ) {
                        $match = "MIS-MATCH IN COUNTS";
                    }

                    printf "%-45s     files: %4d     datafiles: %4d    expected: %4d      bz2: %4d       YY: %4d     YYY: %4d     %s\n", 
                        $dirMonth, $nFiles, $nFilesY, $nFilesExpected, $nFilesYBz2, $nFilesYY, $nFilesYYYY, $match;
                }
            }
        }
    }


}

