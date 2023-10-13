%

# `vim` Regular Expressions

- Find and replace whole words only, use `s/\<word\>/newword/g`. (Note that the `*` and `#` commands populate the current word with this, so you can get use those commands to populate the `/` register with the search term.)

## Notes

`magic` is the default setting, this means non-greedy is `\{-}` and capture groups is `\(\)`.

	\v    \m       \M         \V    matches
	none  'magic'  'nomagic'  none
	$     $        $          \$    matches_end-of-line
	.     .        \.         \.    matches_any_character
	*     *        \*         \*    any_number_of_the_previous_atom
	~     ~        \~         \~    latest_substitute_string
	()    \(\)     \(\)       \(\)  grouping_into_an_atom
	|     \|       \|         \|    separating_alternatives
	\a    \a       \a         \a    alphabetic_character
	\\    \\       \\         \\    literal_backslash
	\.    \.       .          .     literal_dot
	\{    {        {          {     literal_'{'
	a     a        a          a     literal_'a'

## Pattern Modifiers

* `/\v`: Very magic search makes most special characters take on their meaning.
* `/\V`: `verynomagic` search, no special characters, everything is interpreted literally.
* `/\c`: Ignore case
* `/\C`: Case sensitive

By default Vim searches for the literal characters for most punctuation (excluding `[]`, `.`, `*`, others? These need to be normally need to be escaped).

## Special Characters

* Use `\{-}` instead of `*` for non-greedy (or `{-}` with `\v`)
* `.`: Any character except new line
* `\s`: Whitespace character
* `\S`: Non-whitespace character
* `\d`: Digit
* `\D`: Non-digit
* `\x`: Hex digit
* `\X`: Non-hex digit
* `\o`: Octal digit
* `\O`: Non-octal digit
* `\h`: Head of word character (`a`, `b`, `c...z`,`A`, `B`, `C...Z` and `_`)
* `\H`: Non-head of word character
* `\p`: Printable character
* `\P`: Like `\p`, but excluding digits
* `\w`: Word character
* `\W`: Non-word character
* `\a`: Alphabetic character
* `\A`: Non-alphabetic character
* `\l`: Lowercase character
* `\L`: Non-lowercase character
* `\u`: Uppercase character
* `\U`: Non-uppercase character

