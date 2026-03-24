#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Std;

my %opts;
getopts('H', \%opts);

my $destLine = $ARGV[0] // 0;

# Print all lines (default), or only first per hunk (-H)
my $hunks = $opts{H} ? 1 : 0;

my $filename;
my $line;
my $offset = 0;
my $printed = 0;
my $lineNumber = 0;
while (<STDIN>) {
   $lineNumber++;
   if (m(^diff --git a/.*? b/(.*)$)) {
      $printed = 0;
      $line = 1;
      $offset = 1;
      $filename = $1;
      $filename =~ s/\s+$//;
   } elsif (m(^\+\+\+ b/(.*)$)) {
   } elsif (m(^\-\-\- a/(.*)$)) {
      $printed = 0;
      $line = 1;
      $offset = 1;
      $filename = $1;
      $filename =~ s/\s+$//;
   } elsif (m(^@@@? -\d+(?:,\d+)?.* \+(\d+))) {
      $line = $1;
      $offset = 0;
      $printed = 0;
   } elsif (m(^\+(.*)$)) {
      my $data = $1 || '';
      print "$filename:" . ($offset + $line) . ":$data\n"
         unless ($printed && $hunks) || $destLine > 0;
      $offset++;
      $printed = 1;
   } elsif (m(^\-(.*)$)) {
      my $data = $1 || '';
      print "$filename:" . ($offset + $line) . ":$data\n"
         unless !$hunks || $printed || $destLine > 0;
      # Don't increment the offset for subtracted lines
      $printed = 1;
   } elsif (m(^ )) {
      $printed = 0;
      $offset++;
   }

   if ($lineNumber == $destLine) {
      print "$filename:" . ($offset + $line - 1);
      exit 0;
   }
}
