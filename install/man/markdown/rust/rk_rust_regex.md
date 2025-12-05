# Special Characters

## ASCII Character Classes

- `[[:alnum:]]`: Alphanumeric
- `[[:alpha:]]`: Alphabetic
- `[[:ascii:]]`: Ascii
- `[[:blank:]]`: Blank
- `[[:cntrl:]]`: Control
- `[[:digit:]]`: Digits
- `[[:graph:]]`: Graphical
- `[[:lower:]]`: Lower case
- `[[:print:]]`: Printable
- `[[:punct:]]`: Punctuation
- `[[:space:]]`: Whitespace
- `[[:upper:]]`: Upper case
- `[[:word:]]`: Word characters
- `[[:xdigit:]]`: Hex digit

## Perl Character Classes

- `\b` / `\B`: Word boundary / not word boundary (matches a *position*, not a character, e.g., can match EOL)
- `\d` / `\D`: Digit / not digit
- `\s` / `\S`: Whitespace / not whitespace
- `\w` / `\W`: Word character / not word character

## Empty Matches

- `^`: The beginning of text (or start-of-line with multi-line mode)
- `$`: The end of text (or end-of-line with multi-line mode)
- `\A`: Only the beginning of text (even with multi-line mode enabled)
- `\z`: Only the end of text (even with multi-line mode enabled)
