Note that `b` is *not* simply shorthand for `breakpoint`, these commands require `breakpoint`.

- `(lldb) breakpoint set -n`: Set a breakpoint by a symbol, e.g., for a function name
- `(lldb) breakpoint set --file test.c --line 12` / `b test.c:12`
- `(lldb) breakpoint list`: List breakpoints (note `b list` does not work)
- `(lldb) breakpoint delete 1`
- `(lldb) breakpoint enable 1`
- `(lldb) breakpoint disable 1`
- `(lldb) breakpoint delete`: Delete all breakpoints

- `(lldb) process handle SIGSEGV --stop false`: Stop breaking on `SIGSEGV`
