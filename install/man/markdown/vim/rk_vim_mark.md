- `ma`: Make mark called `a`
- `<backtick>a`: Go to `a` (line and column)
- `'x`: Go to `x` (line only)
- `:marks`: List marks
- `<backtick><backtick>`: Go to location before last motion
- `''`: Go to line before last motion
- `:marks`: List marks
- `:marks a`: List individual marks
- The numbered marks

# Marking

- `ma`: Set file local mark `a` (every file can have a mark `a`)
- `mA`: Set global mark `A` (one `A` per session, can be used to jump across files)
- `'a`: Go to line of mark `a`
- `<backtick>a`: Go to line and column of mark `a`

# File Marks

- The number marks are the most recently opened files
- `'{count}`: Open a recent file (with `0` being the most recent)
- `'0`: Open the most recent file, this is b

# Special Marks

- `[` / `]`: Beginning / end of last changed or yanked text
- `<` / `>`: Beginning / end of last visual selection
- `.`: Last change

# Examples

- `>'[`: Indent the last changed lines (e.g., after `put *`)
