# `lldb`

- `↩`: Repeat last command
- `lldb <path-to-program>`: Load program
- `(lldb) file <path-to-program`: Load program
y- `(lldb) run`: Start program
- `^D`: Quit (this probably isn't `^C` so that `^C` can be used to interrupt commands)

## Commands

- `run <parameters>`: Run passing parameters to the executable
- `step`
- `next`
- `continue`
- `frame select 0` / `fr s 0`: Print the current frame information (e.g., current source code line)
- `source list`: Display source code for the current target process
- `source info <file path>`: Display source line information for the current target process
- `⌃C`: Seems to stop the process?

## Debug Builds

### Linux

- `file`: Will say `not stripped` if it's a debug build
- `objdump --syms`: Dumps debug symbols

### macOS

- `otool -Iv`
