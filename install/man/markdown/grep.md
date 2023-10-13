# `grep`

- `-E` / `--extended-regexp`: Support or, e.g., `grep -E "open class|open var"`
- `-v` / `--invert-match`: Invert matches
- `-o` / `--only-matching`: Only show match

## Versions

- `-Z` / `--null`: Use null byte line terminator (does work on macOS `grep`, just use `tr '\n' '\0'`

## Special

- `grep .`: Delete blank lines
