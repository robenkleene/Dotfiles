- `-E` / `--extended-regexp`: Support or, e.g., `grep -E "foo|bar"`
- `-v` / `--invert-match`: Invert matches
- `-o` / `--only-matching`: Only show match
- `--include=<glob>`: Include glob (can be added multiple times)
- `--exclude=<glob>`: Exclude glob (can be added multiple times)
- `--exclude-dir=<glob>`: Exclude glob (can be added multiple times)

# Brace Expansion

Brace expansion can be used to search for multiple file extensions:

```
grep -nr '--include=*.'{foo,bar} 'baz'
```

Expands to

```
grep -nr --include=\*.foo --include=\*.bar 'baz'`
```

# Versions

- `-Z` / `--null`: Use null byte line terminator (does work on macOS `grep`, just use `tr '\n' '\0'`

# Special

- `grep .`: Delete blank lines
