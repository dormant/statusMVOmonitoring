#!/usr/bin/perl
#

my $wgot = `wget http://172.17.102.21/sd/init.log 2>&1 | grep saved`;
chomp $wgot;

print $wgot, "\n";
