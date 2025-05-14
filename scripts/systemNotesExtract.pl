#!/usr/bin/perl
#
# Creates prose from station info spreadsheet 
# R.C. Stewart, 2023-02-16
# v2, 2025-03-26

use strict;
use warnings;
use Env;
use Spreadsheet::XLSX;
use Term::ANSIColor;
use Time::timegm qw(timegm);

#my $rightNow = timegm(gmtime);
my $rightNow = scalar gmtime;

my $fileData = '../spreadsheets/systemNotes.xlsx';
my $workbook = Spreadsheet::XLSX->new($fileData);

my $row;
my $asset;
my $status;
my $datimBeg;
my $datimEnd;
my $what;
my $comment;

my @allRows;

my $numArgs = $#ARGV + 1;
my $runMode = "now";
if( $numArgs == 1 ){
    $runMode = $ARGV[0];
}

$runMode =~ s/full/full history/;
$runMode =~ s/chron/chronology/;

printf( "%s  %s UTC\n", "Seismic System Status", $rightNow);

foreach my $worksheet (@{$workbook->{Worksheet}}) {

    my $nameSheet = $worksheet->{Name};

    $worksheet->{MaxRow} ||= $worksheet->{MinRow};
    foreach my $row (1+$worksheet->{MinRow} .. $worksheet->{MaxRow}) {

        $worksheet->{MaxCol} ||= $worksheet->{MinCol};

        my $cell = $worksheet->{Cells}[$row][0];
        if( $cell ) {
            $asset = $$cell{Val};
        } else {
            $asset = "";
        }

        $cell = $worksheet->{Cells}[$row][1];
        if( $cell ) {
            $status = $$cell{Val};
        } else {
            $status = "";
        }

        $cell = $worksheet->{Cells}[$row][2];
        if( $cell ) {
            $datimBeg = $$cell{Val};
        } else {
            $datimBeg = "";
        }

        $cell = $worksheet->{Cells}[$row][3];
        if( $cell ) {
            $datimEnd = $$cell{Val};
        } else {
            $datimEnd = "";
        }

        $cell = $worksheet->{Cells}[$row][4];
        if( $cell ) {
            $what= $$cell{Val};
        } else {
            $what= "";
        }

        $cell = $worksheet->{Cells}[$row][5];
        if( $cell ) {
            $comment= $$cell{Val};
        } else {
            $comment= "";
        }


        if( $runMode eq "chronology" ) {
            my $rowForAll = sprintf( "%20s    %-13s  %-6s  %13s  %13s  %-60s %-60s", $datimBeg, $asset, $status, $datimBeg, $datimEnd, $what, $comment );
            push( @allRows, $rowForAll );
            if( $datimEnd ne "" ){
                my $newStatus = "On";
                if( $status eq "Fault" ){
                    $newStatus = "Fixed";
                }
                $rowForAll = sprintf( "%20s    %-13s  %-6s  %13s  %13s  %-60s %-60s", $datimEnd, $asset, $newStatus, $datimBeg, $datimEnd, $what, $comment );
                push( @allRows, $rowForAll );
            }

        } elsif( $runMode eq "now" ) {
            if ( ( $status eq "Off" || $status eq "Fault" ) && $datimEnd eq "" ) {
       	        printf( "%-20s  %-6s  %20s  %13s  %-60s %-60s\n", $asset, $status, $datimBeg, $datimEnd, $what, $comment );
            }
        } elsif ( $runMode eq "full history" ) {
            my $rowForAll = sprintf( "%-13s  %-6s  %13s  %13s  %-60s %-60s", $asset, $status, $datimBeg, $datimEnd, $what, $comment );
            push( @allRows, $rowForAll );
        }

	}

}


if( $runMode ne "now" ) {
    print color('reset');
}


if( $runMode eq "chronology" || $runMode eq "full history") {
    print join("\n", sort( @allRows )), "\n";
}
