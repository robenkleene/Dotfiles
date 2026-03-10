# Switching

- `<prefix>o`: Next pane
- `<prefix>;`: Last pane
- `<prefix>q`: Display pane numbers then jump to pane by number

# Moving

- `<prefix>{` / `<prefix>}`: Swap panes with pane above / below
- `<prefix>!`: Move current pane to new window
- `<prefix>M-o`: Swap panes (`rotate-window -D`)

# Splitting

- `<prefix>"`: Split window horizontally
- `<prefix>%`: Split window vertically

# Closing

- `:kill-pane -a`: Kill other panes
- `<prefix>x`: Kill pane

# Joining

- `<prefix>m`: Mark the current pane (then switch to another window and use `:join-pane` to bring that pane to the new window)
- `<prefix>!`, `:break-pane`: Break a pane out to its own window

# Layout

`tmux` calls arranging panes layout.

- `<prefix>E`: Make panes equal size
- `<prefix>M-5`: Tile panes

# Resizing

These can be repeated without doing the leader key (i.e., they're assigned with the `bind-key` `-r` flag).

- `<prefix>⌥←` / `<prefix>⌥↑` / `<prefix>⌥←` / `<prefix>⌥↓`: Resize pane by `5` in direction
- `<prefix>^←` / `<prefix>^↑` / `<prefix>^←` / `<prefix>^↓`: Resize pane by `1` in direction

# Marks

The marked pane is the default target for -s to `join-pane, `move-pane`, `swap-pane`, and `swap-window`.

- `<prefix>m`: Mark pane
- `<prefix>M`: Clear marked pane

# Other

- `<prefix>>`: Show a menu with various split and kill options
- `<prefix>z` / `resize-pane -Z`: Make pane full screen
