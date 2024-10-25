- `n`: Next search
- `N`: Previous search
- The `set wrapscan` open sets whether search wraps by default (it's on by default)

# Using `gn`

**Visual Method**: After doing a search, type `gn` to select the next match, then type `n` to go to the next match, then `gn` again to select, then `.` to perform the previous operation.

**Motion Method**: Do a motion edit like `cgn`, this will edit the next match, after the edit hit the `.` to perform the same operation on the next match automatically.

- `dgn`: Delete the next match

# `g/`

- `g/^$/d`: Delete blank lines
