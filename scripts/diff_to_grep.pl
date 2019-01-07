#!/usr/bin/env perl

use strict;
use warnings;

# Orginally named `diff-hunk-list`

my $filename;
my $line;
my $offset = 0;
my $printed = 0;
while (<STDIN>) {
   if (m(^\+\+\+ b/(.*)$)) {
      $printed = 0;
      $filename = $1;
      $filename =~ s/\s+$//;
   } elsif (m(^@@ -\d+(?:,\d+)? \+(\d+))) {
      $line = $1;
      $offset = 0;
      $printed = 0;
   } elsif (m(^\+(.*)$)) {
      my $data = $1 || '-';
      print "$filename:" . ($offset + $line) . ":$data\n"
         unless $printed;
      $offset++;
      $printed = 1;
   } elsif (m(^ )) {
      $printed = 0;
      $offset++;
   }
}
