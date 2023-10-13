%

# `vim` Paths

No these will only work for commands that take a file path, e.g., `:e %:h` will work, but `:echo %` will not.

`echo expand('%')` will also work. 

`:h expand()` for more.

- `%`: Relative path
- `%:p`: Absolute path
- `%:h`: Head (parent)
- `%:t`: Tail (filename)
- `%:e`: File extension
- `%:r`: Filename without extension

## Examples

- `let @a = expand('%:t)`: Yank current filename to register `a`

## Command-Line Mode

- `<c-r>%`: Insert the relative path

## Insert Mode

- `<c-r>%`: Insert the absolute path
- `<c-r>=expand("%:p")`: Insert with a modifier
