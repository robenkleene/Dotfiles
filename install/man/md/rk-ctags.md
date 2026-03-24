- `ctags -R .`: Recursive
- `ctags *`: Local
- `--languages=C++`: Only one language (with every file parsed)
- `fd -g '*.{h,cpp} -X ctags': Faster way to specify one file type

# Notes

- `--extras=+f`: Add files so that `tags <filename>` works to open the file, note this doesn't work in the `.ctags` file for some reason
- The `--recurse=yes` option can be instead added to the `~/.ctags` file
