#!/usr/bin/env perl

use Getopt::Long;
my $alternate;
GetOptions ("d"  => \$alternate)
or die("Arguments error\n");

my $search;
if ( $alternate ) {
	$search = "http://www.duckduckgo.com/?q=";
} else {
	$search = "http://www.google.com/search?q=";
}

while (<>) {
	# Remove `http` or `https`
	$_ =~ s{http://}{}gi;
	$_ =~ s{https://}{}gi;
	$_ =~ s{/.*}{}gi; # strip everything after first slash (only search the
			  # base domain)
	chomp($_);
	$search .= "site:$_+OR+";
}
$search =~ s/\+OR\+$//; # Remove last +OR+

`open "$search"`;
