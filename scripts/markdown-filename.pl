#!/usr/bin/env perl

sub title_from_line {
	# Trim white space
	$_[0] =~ s{^\s+|\s+$}{}gi; 

	# Markdown Links
	$_[0] =~ s{\[([^\]]+)\]\(([^)]+)\)}{$1}gi; # Replace markdown links with just the link name portion	
	# Replace Special Characters
	# "Special characters" are everything except underscores, spaces, ampersand, numbers & letters. "_" is the replacement character.
	$_[0] =~ s{^[^\w\s&]+|[^\w\s&]+$}{}gi; # Replace leading and trailing special characters
	$_[0] =~ s{[^\w\s-&]}{_}gi; # Replace inline special characters
	$_[0] =~ s{_+}{_}gi; # Replace consecutive replacement characters with one

	# Inline White Spaces
	$_[0] =~ s{\s+}{ }gi; # Consolidate multiple spaces to one spaces
	# Trim white space
	$_[0] =~ s{^\s+|\s+$}{}gi; 

	# Truncate to 80 Characters and remove the last (incomplete) word
	if (length($_[0]) > 80) {
		$_[0] = substr($_[0], 0, 80);
		$_[0] =~ s/\W\w+$//;
	}

	# Trim white space
	$_[0] =~ s{^\s+|\s+$}{}gi;

	$_[0];
}

while (<>) {
	$title = &title_from_line($_);	
	if ($title) { last };
}

if ($title) {
	print "$title\n"; # \n at the end makes the output cleaner (outputs a % otherwise)
} else {
	print STDERR "No valid filename found\n";
    exit 1;
}


