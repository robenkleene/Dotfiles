- When piping to `vim` (e.g., `pbpaste | q`, which pipes the clipboard to `vim`) then opening a new pane, the default directory for the new pane is lost
- `:show-messages`: Show output history

# Debugging

- `display-message -p "#{pane_current_path}"`
- `display-message -p "#{pane_current_command}"`

# Exited Unexpectedly

`server exited unexpectedly`

Can probably be fixed with `rm -rf /tmp/tmux*`

# Clipboard

- `tmux` has built-in system clipboard support through `set-clipboard` (it's on by default). This means if you make a `tmux` selection and copy, it will automatically sync to the system keyboard (this happens by sending key codes to the terminal program, which then interprets them and sets the system clipboard). This even works when the `tmux` session is on a remote server (e.g., when connected to the serer over `ssh`).
- `tmux loadb -w` seems to provide some of this functionality, but doesn't seem to work over `ssh` like the `set-clipboard` support does (e.g., `echo "foo" | tmux loadb -w -` will set the system clipboard when run locally, but won't when run on a remote server.)

## Troubleshooting

- Show the values of `set-clipboard` with `tmux show -s set-clipboard` (it should be `on` or `external` to sync with the system clipboard)
- The clipboard feature depends on the `Ms` unofficial `terminfo` extension, make sure it's set with `tmux info | grep Ms` (it'll say `[missing]` if it's not set)
- Setting the local clipboard from a remote session does not work in `mosh` because `mosh` strips OSC 52 clipboard operations
