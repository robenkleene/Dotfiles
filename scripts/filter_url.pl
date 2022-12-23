#!/usr/bin/perl

use Getopt::Long;

my $break;
GetOptions('b|break' => \$break);

while (<>) {
	my $found = 0;
	while ($_ =~ m{(\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/))))}gisx) {
		print "$1";
		if (defined $break) { 
			$found = 1;
			last; 
		} else {
			print "\n";
		}
	}
	if ($found) {
		last;
	}
}

