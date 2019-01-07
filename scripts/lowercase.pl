#!/usr/bin/env perl

use strict;
use warnings;

while (<>) {
	s/.*/\L$&/g
} continue {
	print or die "-p destination: $!\n";
}

