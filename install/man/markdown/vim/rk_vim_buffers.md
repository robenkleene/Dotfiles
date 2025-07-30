- `:ls` / `:buffers` / `:files`: List buffers

- `:bp[revious]` / `:bn[ext]`: Switch to previous / next buffer
- `:b <term><tab>`: Tab complete a file in the buffer list based on part of it's name
- `:b[uffer]<buffer-number>` / `:<buffer-number>b`: Switch to a buffer by number from `ls`
- `:sb[uffer]<buffer-number>` / `:<buffer-number>sb`: Switch to a buffer by number from `ls` in a horizontal split
- There's no command to open a buffer number in a vertical split, but `:vert[ical] sb<buffer-number>` works
- `:b[uffer] <buffer-name>`: Switch a buffer by name with tab completion (note this works both for the buffer list and arguments list)
- `{count}CTRL-^`: Switch to count numbered buffer
- `CTRL-^`, `:b#`: Edit previous buffer

## Multiple

- `b<buffer-number1> | vert sb<buffer-number2>`: Open multiple buffers in splits

## Closing

- `bd[elete] <buffer-number>`: Close a buffer (defaults to current buffer)

# Find

- `find **/*.<extension>`: Recursively match a file

# Recent Files

- `:ol[dfiles]` / `:bro[wse] ol[dfiles]`: List old files
- `:filt[er] /pattern/ ol`: Present a list of old files that match filter (`:filter` is always case sensitive by default, use `/\cpattern/` to ignore case)
- You can hit `:` in this list to enter an edit command, e.g., `e #<1` to edit old file number `1`
- `:e[dit] #<1`: Edit most recent file (`#<2` to edit second most recent, etc...), note that this *only* works for the most recent file list, e.g., not for the buffer list)
- `:sp[lit] #<1`: Edit old file in horizontal split
- `:vs[plit] #<1`: Edit old file in vertical split

## Multiple

- `b<buffer-number1> | vert sb<buffer-number2>`: Edit multiple old files in splits
- `:ar[gs] #<1 #<2`: Edit multiple old files (adds them to the `argslist`, does not open them in splits)

# Marks

Another way to open a recent file is to use the `:marks` list, this is because the numbered marks automatically map to the most recently edited files. So `'<count>` opens recent files, e.g., `'0` to open the most recent file.
