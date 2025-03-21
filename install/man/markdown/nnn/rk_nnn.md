- `␣`: Tag file
- `^G`: Quit and `cd` (if `cd` on quit is configured to always happen, there's no way to not `cd` on quit)
- `1` / `2` / `3` / `4`: Switch to tab
- `nnn <file-path>`: Open `nnn` with file highlighted
- `^L`: Redraw (force a refresh)
- `F`: Show details (like file modification time) about the current file
- `D`: Toggle details mode
- `.`: Toggle show hidden files

# Selection

- `␣` / `+`: Toggle selection
- `a`: Select all
- `A`: Invert selection

# Navigation

- `C-u` / `C-d`, `PgUp` / `PgDn`: Page up / down

# Help

- `?`: Show shortcuts (dumped to terminal so you can see them on quit)

# Operations

- `o`: Choose program to open with
- `e`: Edit file (e.g., an empty file that can't be edited with return)
- `x`, `^X`: Delete file or directory (recursively)
- `^R`: Rename file
- `p`: Copy to new location
- `v`: Move to new location
- `^R`: Duplicate file (hit enter when prompted to rename and it will ask for a new name to copy to)
- `nf`: New file
- `nd`: New directory
- `r`: Batch rename in `EDITOR` (e.g., `Vim` by default)
