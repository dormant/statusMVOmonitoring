#!/usr/bin/perl
#
# Checks for missing SEISAN event data files
#
# R.C. Stewart 2024-08-27
#

use strict;
use warnings;
use DateTime;
use DateTime::Format::ISO8601;
use Time::DaysInMonth;

my $dirRea = '/mnt/mvofls2/Seismic_Data/REA/MVOE_';

my @dirsYear = grep {-d} glob "$dirRea/*";
for my $dirYear (@dirsYear) {
    if( $dirYear =~ /MVOE_\/[12]/ ){

        my $year4 = substr( $dirYear, -4 );
        my $year2 = substr( $dirYear, -2 );

        my @dirsMonth = grep {-d} glob "$dirYear/*";
        for my $dirMonthRea (@dirsMonth) {
            if( $dirMonthRea =~ /\d\d$/ ){

                my $month = substr( $dirMonthRea, -2 );

                opendir(my $dh, $dirMonthRea) || die "Can't opendir $dirMonthRea $!";
                my @files = readdir($dh);
                closedir $dh;
                my $nFilesRea = scalar @files;
                my $nFilesYRea = scalar ( grep { /^\d/ } @files );

                my $dirMonthWav = $dirMonthRea;
                $dirMonthWav =~ s/REA/WAV/;
                my $nFilesWav;
                my $nFilesYWav;
                if( -d $dirMonthWav ){
                    opendir($dh, $dirMonthWav) || die "Can't opendir $dirMonthWav $!";
                    @files = readdir($dh);
                    closedir $dh;
                    $nFilesWav = scalar @files;
                    $nFilesYWav = scalar ( grep { /^\d/ } @files );
                } else {
                    $nFilesWav = 0;
                    $nFilesYWav = 0;
                }

                my $match = '';
                if( $nFilesYWav == 0 ) {
                    $match = "MISSING DIRECTORY";
                } elsif( $nFilesYWav != $nFilesYRea ) {
                    $match = "MIS-MATCH IN COUNTS";
                }
                printf "%-45s     files: %4d     reafiles: %4d     wavfile: %4d     %s\n",
                    $dirMonthRea, $nFilesRea, $nFilesYRea, $nFilesYWav, $match;
            }
        }
    }
}



