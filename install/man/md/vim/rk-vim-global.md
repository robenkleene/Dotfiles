- `g[lobal]/`

# Delete

- `:g/^$/d`: Delete blank lines
- `:g/foo/d`: Delete lines matching pattern
- `:v[global]/` / `g!/`: Invert (i.e., like `grep -v`, `v/foo/d`, delete lines *not* matching pattern)
- `:v/foo/d`, `g!/foo/d`: Delete all other lines (`:v` and `g!` are synonyms)
- `:g/^$/d`: Delete blank lines
- `:bufdo g/foo/d`: Delete lines matching pattern in all buffers

# Print

- `:g/foo/p`: Print lines matching pattern
- `:g/foo/p`: Print lines matching pattern (to then populate the quick fix list with the pattern, use `:vim[grep] /foo/ %`

# Yank

- `:g/foo/yank A`: Yank matching lines to register `a` (this works because `A` is uppercase, so the lines are *appended* to the register, this is why this can't be used to yank directly to the system clipboard)

# `norm[al]`

- `:g//norm gcc`: Perform a normal mode command on every matched search
