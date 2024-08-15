Buffer is what tmux calls the copy/paste locations.

- `tmux save-buffer` / `tmux saveb -`: Print the contents of the default buffer to standard output
- `tmux load-buffer -` / `tmux loadb -`: Save standard input to the default buffer

# Flags

- `-b <buffer-name>`: Specify a named buffer
