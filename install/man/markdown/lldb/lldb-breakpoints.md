# `lldb` Breakpoints

Note that `b` is *not* simply shorthand for `breakpoint`, these commands require `breakpoint`.

- `breakpoint set -n`: Set a breakpoint by a symbol, e.g., for a function name
- `breakpoint set --file test.c --line 12` / `b test.c:12`
- `breakpoint list`: List breakpoints (note `b list` does not work)
- `breakpoint delete 1`
- `breakpoint enable 1`
- `breakpoint disable 1`
- `breakpoint delete`: Delete all breakpoints
