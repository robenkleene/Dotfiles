# `zsh` Glob

## Modifiers

- `(#i)(foo)*`: Case insensitive
- `(om)`: Sort by modification time
- `(n)`: Sort files numerically (e.g., `pdfjoin chapter*.pdf(n) -o all.pdf`)
- `(P:--exclude:)`: Prefix a flag (e.g., `tar czvf foo.tar.gz * *.tmp(P:--exclude:)`)

## Numbers

- `<42-69>`: Globs numbers between `42` and `69`
