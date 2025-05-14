#!/usr/bin/perl -w
#
# Processes data availability data from wws_da.sh
#
# R.C. Stewart, 20-Jun-2021

my $dataDir = "/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily/";
opendir( DIR, $dataDir ) || die "Error opening $dataDir\n";
my @files = grep( /\.html$/, readdir( DIR ) );

my $outFile = "wws_da.csv";
open( OF, '>', $outFile ) or die $!;

my %dataAvail;

foreach my $file (sort @files)
{
#	print $file . "\n";

	my @tmp = split( /\./, $file );
	my ($sta,$dat) = split( /\-/, $tmp[0] );

	my $ffile = join( '', $dataDir, $file );

	my $daLine = `grep '%' $ffile`;

	$daLine =~ /TD>(.*)%/;
	my $daPercent = $1;

    if( $daPercent < 0 ) {
        $daPercent = 0.0;
    }

	$dataAvail{$dat}{$sta} = $daPercent;

	print OF join( ', ', $sta, $dat, $daPercent ), "\n";
}

close( OF );

$dataDir = "/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws";
$outFile = join( '/', $dataDir, "data_availability_wws.txt" );
open( OF, '>', $outFile ) or die $!;


my @stations = qw( MBBY MBFL MBFR MBGB MBGH MBHA MBLG MBLY MBRV MBRY MBWH MSS1 );
my $da;

printf OF "%-10s%10s%10s%10s%10s%10s%10s%10s%10s%10s%10s%10s%10s\n", 'Date', @stations;

for my $key ( reverse sort keys %dataAvail ) 
{
	my $datestring = join( '-', substr($key,0,4), substr($key,4,2), substr($key,6,2) );
    printf OF "%10s", $datestring;
    for my $stat (@stations)
    {
	if( exists $dataAvail{$key}{$stat} ) {
		$da = $dataAvail{$key}{$stat};
		$da += 0;	
	} else {
		$da = 0;
	}
        printf OF  "%10.0f", $da;
    }
	print OF "\n";
}
close( OF );
