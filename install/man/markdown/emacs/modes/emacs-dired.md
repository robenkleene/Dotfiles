- `C-x C-j`: Dired jump
- `C-x 4 C-j`: Dired jump other window
- `C-x 5 C-j`: Dired jump other frame
- `^`: Up directory
- `+`: Create directory
- `C-x C-f`: Create a new file (`ido-mode` interferes with inserting spaces in a filename, to get around those use `C-f` to drop down to the default `find-file` interface)
- `D`: Delete file
- `s`: Toggle between alphabetical and date sorting
    - To sort by size use `C-u s` then add `S` to the list of flags to sort by size
- `R`: Rename (or move) file
- `0 w` / `dired-copy-filename-as-kill`: Kill path to file
- `C-x C-h`: Cycle through human readable file sizes
- `v`: View (preview) file (then `q` to quit the view)
- `o` / `dired-find-file-other-window`: Open file in other window

## Hidden

- `C-x M-o` / `dired-omit-mode` (requires `dired-x`): Show hidden files (this includes Emacs recovery files)

## Mark

- `m` / `u`: Mark / Remove mark
- `U`: Unmark all
- `t`: Invert marked

## Multiple Files

- Use `m` to mark and then another command, e.g., `R` to move all

## Sorting

- `s`: Toggle sort by name or date
    - `(`: Toggle showing details
- `C-u s`: Set specific flags to pass to `ls`

## Shell Commands

- `!`: Do shell command on file
- `M-!`: Do shell command in current directory

## Dired Write Mode

- `C-x C-q` or `dired-toggle-read-only`: Change to writable mode
	- `C-c C-c` / `C-x C-s`: Save changes
	- `C-c C-k` / `C-c ESC`: Abort changes

## File Management

### Copying, Moving, Renaming

- `R`: Rename or move file (`↓` inserts the current filename)
- `C`: Copy file

With `(setq dired-dwim-target t)`, if two `dired` buffers are open use the other one as the default destination.

To move a file to a new directory, do a rename, but just specify a directory as a path, and the file will be moved with the existing file name.

## Dired Virtual

- `g`: Convert a `dired-virtual` buffer to a normal `dired` buffer

### Creating

- `ls -l`: Output that can be converted to a `dired-virtual` buffer (i.e., you need the additional metadata for it to work)
- `ls -l **/*.md`: In Fish shell, this is the easiest way to get a recursive file list that works with `dired-virtual`
- `fd --strip-cwd-prefix -g "*.js" -l`: For `fd` output compatible with `dired-virtual`
