# Vim Tabs Spaces

## Convert Tabs to Spaces

	set expandtab
	retab!

Through command line application:

	!expand

## Convert Spaces to Tabs

	set noexpandtab
	retab!

Through command line application:

	!unexpand -t 2

`2` is number of spaces per tab, default is `8`.
