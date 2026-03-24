# Attach

## Process

### ID

- `lldb -p <PID>`
- `(lldb) process attach --pid <PID>`

### Name

- `lldb -n <process_name>`
- `lldb -n <process_name> -w`: Wait for process to appear

## File

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
