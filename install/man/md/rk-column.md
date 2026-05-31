- `column -t`: Layout into tab delimited columns
- `column -t -s <delimiter>`: Specify the delimiter to use when laying out (e.g., `,`). Note that the *delimiter* is removed, e.g., this can't be used to comma align a comma-delimited file because the commas would be removed.

# Examples

- `column -t -s $'\t'`: Layout tab-delimited (`.tsv)` as columns (`$` before a single quoted string expands escape sequences)
