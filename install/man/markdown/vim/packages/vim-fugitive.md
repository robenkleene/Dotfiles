%

# `vim` Fugitive

Fixing "Not an editor command": This happens if you open a file without first `cd` to a directory in `git` directory. To resolve it, first `cd` to a `git` directory, and then edit the file again `:edit %`.

## `Gstatus`

* `-`: Stage file
* `cc`: `Gcommit`
- `X`: Discard changes
- `=`: Inline diff of file under cursor

## `Gdiff`

* `<C-w><C-o>`: Exit a `Gdiff` (It appears that the working directory version of the file needs to be active first)

