# Basic

- `r` / `run`: Run (with parameters, e.g., `run <parameters>` passes parameters to the executable)
- `s` / `step`: Step into
- `n` / `next`: Step over
- `finish`: Finish the current stack frame (equivalent to step out)
- `c` / `continue`: Continue execution
- `↩`: Repeat last command
- `q` / `^D`: Quit (this probably isn't `^C` so that `^C` can be used to interrupt commands)
- `f` / `frame select 0` / `fr s 0` / `f 0`: Print the current frame information (e.g., current source code line)

# Setup

- `lldb <path-to-program>`: Load program
- `(lldb) file <path-to-program`: Load program
- `(lldb) run`: Start program

# Source

Info about the current file.

- `source list`: Display source code for the current target process
- `source info` / `source info <file path>`: Display source line information for the current target process (this will show the full path to the current file)

# Running

- `call <function>`: Call a function

# Debug Builds

## Linux

- `file`: Will say `not stripped` if it's a debug build
- `objdump --syms`: Dumps debug symbols

## macOS

- `otool -Iv`
