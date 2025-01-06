No these will only work for commands that take a file path, e.g., `:e %:h` will work, but `:echo %` will not.

`echo expand('%')` will also work. 

`:h expand()` for more.

- `%`: Relative path

# Modifiers

- `%:p`: Absolute path
- `%:h`: Head (parent)
- `%:t`: Tail (filename)
- `%:e`: File extension
- `%:r`: Filename without extension

## Examples

### Registers

- `let @a = expand('%:t)`: Yank the current filename (`:t`) to register `a` (note that this doesn't trigger `TextYankPost`)
- `let @a = expand('%:p:h)` Yank the absolute path (`:p`) to the directory of the current file (`:h`) to register `a`

### Shell Commands

Note that when using shell commands modifiers always expand to the full path

- `:!echo %<tab> | pbcopy`: Copy the relative path to the file using shell commands
- `:!echo %:h<tab> | pbcopy`: Copy the relative path to the parent directory using shell commands
- `:!echo %:p<tab> | pbcopy`: Copy the absolute path to a file using shell commands
- `:!echo %:p:h<tab> | pbcopy`: Copy the absolute path to the parent directory using shell commands
- `!pwd | pbcopy`: Yank current path

# Insert / Command-Line Mode

- `<c-r>%`: Insert the relative path
- `<c-r>=expand('%:p')`: Insert a path with a modifier

# `cd`

- `cd %:h`: Go to the parent directory when editing a file.
