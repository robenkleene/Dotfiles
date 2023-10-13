# `zsh` Variables

- `typeset -p <variable>`: Print more info about a variable

## Expansion

- `man zshexpn`: Help on expansion

### Flags

- `${(q)foo}`: Escape special file system characters in variable
- `${(qq)foo}`: Escape special file system characters in variable and wrap in single quotes
- `${(qqq)foo}`: Escape special file system characters in variable and wrap in double quotes
- `${(qqqq)foo}`: Escape special file system characters in variable and add `$` wrap
- `vim ${(f)"$(pbpaste)"}`: Each line on clipboard as separate file
    - `(f)` is substitution flag to treat each word as a new line
