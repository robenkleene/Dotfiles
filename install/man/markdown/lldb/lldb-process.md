%

# `lldb` Process

- `(lldb) process launch`: Start program
- `(lldb) process launch -i <file-path>`: Start program, passing `<file-path>` to the programs STDIN
- `(lldb) process launch -i <file-path>`: Start program with STDIN and arguments

## Attach

- `-n` / `--name`: Attach to process by name
- `-w` / `--waitfor`: Wait for process to launch
- `(lldb) process attach -n <binary-name> -w`: Attach to process after it launches
