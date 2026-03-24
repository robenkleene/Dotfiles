- `-q <file>`: Process error list from `<file>` (there isn't a way to use this with standard input, `vim -q <(<command>)` works sometimes, but seems to try to execute backticks so should be avoided)

# `vimrc`

- `-u NONE`: Use all default settings without loading a custom `.vimrc` file

# Commands

- `-c {command}`
- `-c cb[uffer]`: Load an error list from standard input
- Use `|` for multiple commands, e.g., `rg <term> | vim -c 'lcd <backtick>hgroot<backtick> | cb' -`
