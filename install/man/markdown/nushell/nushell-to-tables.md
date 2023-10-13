# Nushell to Tables

Making a table from a string:

- `"red,green,blue" | split column ","`: Split based on delimiter

- `"acronym,long\nAPL,A Programming Language" | from csv`: From csv
- `"name  duration\nonestop.mid  4:06" | from ssv`: From ssv
- `"rank\tsuit\nJack\tSpades\nAce\tClubs" | from tsv`: From tsv

## Parse

- `'Nushell 0.80' | parse '{shell} {version}'`: From whitespace
- `'where all data is structured!' | parse --regex '(?P<subject>\w*\s?\w+) is (?P<adjective>\w+)'`: From regex

## Real Example

- `hg diff -r "bottom^" --root . | diff_to_grep | lines | split column ':'`
