- `find . -name <glob>`: Find in name

# Multiple File Extensions

Use regular expressions, e.g., `find . -regex '.*\.(foo|bar)$'`

# Commands

- `find . -exec <cmd> {} \;`: Run `cmd` once for each file
- `find . -exec <cmd> {} +`: Run `cmd` with the files passed as parameters
