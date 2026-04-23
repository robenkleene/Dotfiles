Buffer is what `tmux` calls the copy/paste locations.

- `:choose-buffer` / `<prefix>=`: Paste from buffers (e.g., clipboard history), the buffer name is listed here (e.g., as `buffer<number>`)

# CLI

- `tmux save-buffer -` / `tmux saveb -`: Print the contents of the default buffer to standard output (the `-` is a required argument, this can also be a filename to save the buffer to)
- `tmux show-buffer` / `tmux showb`: Also prints the contents of the default buffer, but breaks with some special characters (e.g., accented letters)
- `tmux load-buffer -` / `tmux loadb -`: Save standard input to the default buffer

## Flags

- `-b <buffer-name>`: Specify a named buffer (e.g., `buffer<number>`)
