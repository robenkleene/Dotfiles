#!/usr/bin/env perl

use strict;
use warnings;

while (<>) {
	s/.*/\U$&/g
} continue {
	print or die "-p destination: $!\n";
}

