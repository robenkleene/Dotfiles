%

# `vim` Eunuch

- `Remove`: Delete buffer and on disk
- `Rename <new-name>`: Rename buffer (to get the current filename, first `:lcd`, then `:Rename `, then `<C-r>%` to paste filename from `%` register)

## Notes

- This package seems unnecessary, why not just use `netrw`?
- Use `:saveas <new-name>` to save a file under a new name and edit it
- Use `:w <new-name>` to save a file under a new name and continue editing the same file
