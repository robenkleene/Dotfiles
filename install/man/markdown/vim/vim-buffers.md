# Vim Buffers

- `:ls` / `:buffers` / `:files`: List buffers
- `:b <buffer-number>` / `:<buffer-number>b`: Switch to a buffer by number
- `:bp[revious]` / `:bn[ext]`: Switch to previous / next buffer
- `:b[uffer] <buffer-name>`: Switch a buffer by name with tab completion (note this works both for the buffer list and arguments list)
- `{count}CTRL-^`: Switch to count numbered buffer
- `CTRL-^`: Edit alternate file
- Note that the `CTRL-^` bindings also work with just `CTRL-6`

## Recent Files

- `:ol[dfiles]`: List old files
- `'{count}`: Open a recent file (with `0` being the most recent)
- `'0`: Open the most recent file
