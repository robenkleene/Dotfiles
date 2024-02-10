- `:E`: Open `netrw` in directory of current file
- `:e .`: Open `netrw` in working directory

# Bindings

- `<C-l>`: Refresh the file list
- `cd`: Changes local directory to current directory (this does an `:lcd` not `:cd`)
- `d`: Create directory
- `D`: Delete file
- `R`: Rename (or move) file
- `%`: Create a new file at the current directory
- `a`: Switch between three states of showing hidden files
- `i`: Switch between different display styles (e.g., tree view, showing metadata)
- `p`: Preview file

# Opening Files

- `o`: Open file in horizontal split
- `v`: Open file in vertical split
- `t`: Open file in new tab

# Mark

- `mf`: Mark file
- `mF`: Unmark file
- `mu`: Unmark all
- `mt`: Set mark target directory
- `mc`: Copy marked files to target directory
- `mm`: Move marked files to target directory

## Copy File

1. `mt` to set the target directory
2. `mf` to mark the files
3. `cd` to set the working directory as the same directory as the marked files
4. `mc` to copy the files to the target directory

## Move File

1. `mt` to set the target directory
2. `mf` to mark the files
3. `cd` to set the working directory as the same directory as the marked files
4. `mm` to move the files to the target directory

Note the file list won't update automatically, so refresh with `<C-l>`

## Duplicate File

There's no nice way to do this, using `!cp <src> <dst>`, using `C-r C-f` to fill in the current file at the cursor, is probably the best way.

## Shell Commands

- `mx`: Run shell command on marked files (to specify where the file should appear in the command, use `%`)

# Vinegar

With `vim-vinegar`, `gh` to show hidden files.
