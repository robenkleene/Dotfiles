Recursive

- `ctags -R .`: Recursive
- `ctags *`: Local
- `ctags --language-force="c++" -R *`: Specify only some languages

- `--extras=+f`: Add files so that `tags <filename>` works to open the file, note this doesn't work in the `.ctags` file for some reason
- The `--recurse=yes` option can be instead added to the `~/.ctags` file

## Exec

- `-X <command>`, `--exec-batch <command>`: Execute command on each file *as arguments*
- `-x <command>`, `--exec <command>`: Execute command on each file *in parallel*
