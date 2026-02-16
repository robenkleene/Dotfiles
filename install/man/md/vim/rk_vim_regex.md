# Magic

- `magic` is the default setting, this means non-greedy is `\{-}` and capture groups is `\(\)`, `\|` also needs to be escaped, e.g., `/a_\(foo\|bar\)`

```
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
```

# Pattern Modifiers

* `/\v`: Very magic search makes most special characters take on their meaning.
* `/\V`: `verynomagic` search, no special characters, everything is interpreted literally.
* `/\c`: Ignore case
* `/\C`: Case sensitive

By default Vim searches for the literal characters for most punctuation (excluding `[]`, `.`, `*`, others? These need to be normally need to be escaped).

# Special Characters

* Use `\{-}` instead of `*` for non-greedy (or `{-}` with `\v`)
* `.`: Any character except new line

## More

* `\<` / `\>`: Word start / end (matches a *position*, not a character, e.g., can match EOL)
* `\a` / `\A`: Alphabetic / non-alphabetic character
* `\d` / `\D`: Digit / non-digit
* `\h` / `\H`: Head of word character (`a`, `b`, `c...z`,`A`, `B`, `C...Z` and `_`) / non-head of word character
* `\l` / `\L`: Lowercase / non-lowercase character character
* `\o` / `\O`: Octal digit / non-octal digit
* `\p`/ `\P`: Printable character / Like `\p`, but excluding digits
* `\s` / `\S`: Whitespace character / non-whitespace character
* `\u` / `\U`: Uppercase non-uppercase character
* `\w` / `\W`: Word character / non-word character
* `\x` / `\X`: Hex digit / non-hex digit

# Notes

- To find and replace whole words only, use `s/\<word\>/newword/g`. (Note that the `*` and `#` commands populate the current word with this, so you can get use those commands to populate the `/` register with the search term.)
