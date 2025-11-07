- `:kill-pane -a`: Kill other panes
- `<prefix>x`: Kill pane
- `<prefix>!`: Move current pane to new window
- `<prefix>;`: Last pane
- `<prefix>M-o`: Swap panes (`rotate-window -D`)
- `<prefix>>`: Show a menu with various split and kill options
- `<prefix>z` / `resize-pane -Z`: Make pane full screen

# Splits

- `<prefix>"`: Split window horizontally
- `<prefix>%`: Split window vertically

# Join

- `<prefix>m`: Mark the current pane (then switch to another window and use `:join-pane` to bring that pane to the new window)

# Resizing

These can be repeated without doing the leader key (i.e., they're assigned with the `bind-key` `-r` flag).

- `<prefix>⌥←` / `<prefix>⌥↑` / `<prefix>⌥←` / `<prefix>⌥↓`: Resize pane by `5` in direction
- `<prefix>^←` / `<prefix>^↑` / `<prefix>^←` / `<prefix>^↓`: Resize pane by `1` in direction
