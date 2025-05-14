#!/usr/bin/perl
#
# Extracts latency data from wws 
#
# R.C. Stewart, 21/12/2021

use strict;
use warnings;
use Time::Piece;

my @curlies = `curl -s http://172.17.102.60:16022/menu`;
chomp @curlies;

my @stations = qw( MBFL.HHZ.MV.00 MBFR.HHZ.MV.00 MBGB.HHZ.MV.00 MBGH.HHZ.MV.00 MBHA.SHZ.MV.-- MBLG.HHZ.MV.00 MBLY.HHZ.MV.00 MBRV.BHZ.MV.-- MBRY.BHZ.MV.-- MBWH.BHZ.MV.-- MSS1.SHZ.MV.-- );

my $datimEpoch = time();

foreach my $station (@stations) {

	open( OF, '>>', join( '/', '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_latency_wws', join( '.', $station, '-winston1-data_latency_wws.txt' ) ) ) or die "Can't open file: $!";

	foreach my $curly (@curlies) {

		if( $curly =~ /^<tr/ ){

			$curly =~ s/^<tr><td>//;
			$curly =~ s/<\/td><\/tr>$//;
			$curly =~ s/<\/td><td>/oink/g;
			my @values = split('oink', $curly);
			my $code = join( '.', $values[1], $values[2], $values[3], $values[4] );

			my $dataLatest = Time::Piece->strptime( $values[6], "%Y-%m-%d %H:%M:%S" );

			if( $code eq $station ) {
				print OF $datimEpoch, " ", ($datimEpoch-$dataLatest->epoch()), "\n";
				last;
			}

		}

	}
	close OF;

}
