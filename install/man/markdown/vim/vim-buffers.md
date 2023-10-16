- `:ls` / `:buffers` / `:files`: List buffers
- `b <term><tab>`: Tab complete a file in the buffer list based on part of it's name
- `:b <buffer-number>` / `:<buffer-number>b`: Switch to a buffer by number
- `:bp[revious]` / `:bn[ext]`: Switch to previous / next buffer
- `:b[uffer] <buffer-name>`: Switch a buffer by name with tab completion (note this works both for the buffer list and arguments list)
- `{count}CTRL-^`: Switch to count numbered buffer
- `CTRL-^`: Edit alternate file
- Note that the `CTRL-^` bindings also work with just `CTRL-6`

# Find

- `find **/*.<extension>`: Recursively match a file

# Recent Files

- `:ol[dfiles]` / `:bro[wse] ol[dfiles]`: List old files
- You can hit `:` in this list to enter an edit command, e.g., `e #<1` to edit old file number `1`
- `'{count}`: Open a recent file (with `0` being the most recent)
- `'0`: Open the most recent file
- `:e #<1`: Edit most recent file
- `:e #<2`: Edit second most recent file
