# Emacs Tags

- Generate tags file with the `-e` option on `universal-ctags` (i.e., `ctags -e`, note this option is not available in the default macOS `ctags` version)
- There's a `tags-file-name` variable, but this should not be used, instead use `visit-tag-table` and manually select the file (this is per help for `tags-file-name`)
- Use `xref-find-apropos` to find by tag name, this has a binding, `C-M-.`, but it doesn't work in terminal
