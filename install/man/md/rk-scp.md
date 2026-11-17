`<server>` can be tab-completed, and `<path>` supports `~` for home.

# Download

- `scp <server>:<path> .`: Download a file to the current directory
- `scp -r <server>:<path> .`: Download a directory to the current directory

# Upload

- `scp <file> <server>:<path>`: Upload a file to `<path>`
- `scp -r <dir> <server>:<path>`: Upload a directory to `<path>`
- `scp -r <foo> <bar> <server>:<path>`: Upload several files or directories in one command

# Flags

- `-r`: Required when a source is a directory, including macOS packages like `.app` that look like files in Finder
