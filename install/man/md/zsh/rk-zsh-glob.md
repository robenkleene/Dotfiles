# Modifiers

- `(#i)(foo)*`: Case insensitive
- `(om)`: Sort by modification time
- `(n)`: Sort files numerically (e.g., `pdfjoin chapter*.pdf(n) -o all.pdf`)
- `(P:--exclude:)`: Prefix a flag (e.g., `tar czvf foo.tar.gz * *.tmp(P:--exclude:)`)

# Numbers

- `<1-10>`: Any number between `1` and `10`
- `<->`: Match any (positive) digit
