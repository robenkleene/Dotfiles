%

# `tmux` Troubleshooting

- When piping to `vim` (e.g., `pbpaste | q`, which pipes the clipboard to `vim`) then opening a new pane, the default directory for the new pane is lost
- `:show-messages`: Show output history

## Debugging

- `display-message -p "#{pane_current_path}"`
- `display-message -p "#{pane_current_command}"`
