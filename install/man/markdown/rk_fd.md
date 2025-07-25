`fd` uses smart case by default.

- `-e <file-extension>`: Search by file extension (this option can be used multiple times to specify multiple file extensions)
- `-p` / `--full-path`: Search the full path, not just the filename, e.g., `fd --hidden -p "workflows" -e yml` (This seems to be incompatible with the `-g` glob flag, e.g., `fd --full-path -g "name*json"` will not work)
- `-H` / `--hidden`: Search hidden files
- `-I` / `--no-ignore`: Include ignored files
- `-i` / `--case-sensitive`: Make case sensitive
- `-t d` / `-t f`: Specify only directories / files
- `-X <command>` / `--exec-batch <command>`: Run a command on each file
- `-E` / `--exclude`: Exclude files matching a glob pattern, e.g., `-E '*foo*'` (note that the `rg` syntax, `-g '!foo'` does *not* work!)
- `-l` / `--list-details`: List details (like `ls -l`, this is an alias to `--exec-batch ls -l` with some additional options)

## Exec

- `-X <command>`, `--exec-batch <command>`: Execute command on each file *as arguments*
- `-x <command>`, `--exec <command>`: Execute command on each file *in parallel*

# Globs

- Note that in `fd` globs are case insensitive (in `rg` globs are case sensitive)

# Deleting Files

- `fd <term> -X rm`: Files
- `fd <term> -X rm -r`: Directories

# Troubleshooting

- `fd` doesn't search full paths by default, so `rg "dir.*file"` won't find a `file` in a `dir`, but `fd -p "dir.*file"` will

# Examples

- `fd -F -p 'markdown/fd.md'`: Search for a file in a specific directory
- `fd --hidden "release.yml" --exec fish -c "cd {//}; pwd; git status"`: Perform commands
- `fd -e "md" . ./raster/`: Search a specific path without supplying a pattern (note the `.` as a pattern that matches everything)
- `fd --type executable` / `fd -t executable`: Find all executable files
- `fd -e md -E '*foo*' -E '*bar*'`: Find file extension exclude multiple strings (note this excludes from the whole path, *not just the filename*)
