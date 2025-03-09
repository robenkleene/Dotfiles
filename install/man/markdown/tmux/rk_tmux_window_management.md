# Splits

- `<prefix>"`: Split window horizontally
- `<prefix>%`: Split window vertically

# Navigation

# Sessions

- `:new` / `:new-session`: Create a new session
- `:kill-session`: Kill current session
- `<prefix>L`: Last session
- `<prefix>s`: Session picker
- `<prefix>s <session-number>`: Jump to session

# Window

- `<prefix>{` / `<prefix>}`: Swap active pane with pane above / below
- `<prefix>w`: Window picker
- `<prefix>&`: Kill window
- `<prefix>l`: Last window
- `<prefix>c`: Create window
- `<prefix>p`: Previous window
- `<prefix>n`: Next window
- `<prefix>.`: Move a window by specifying a window number
- `swap-window -t -1` / `swap-window -t +1`: Swap window left / right
- `:kill-window -a`: Kill other windows

# Panes

- `:kill-pane -a`: Kill other panes
- `<prefix>x`: Kill pane
- `<prefix>!`: Move current pane to new window
- `<prefix>;`: Last pane
- `<prefix>M-o`: Swap panes (`rotate-window -D`)
- `<prefix>>`: Show a menu with various split and kill options

# Resizing

These can be repeated without doing the leader key (i.e., they're assigned with the `bind-key` `-r` flag).

- `<prefix>⌥←` / `<prefix>⌥↑` / `<prefix>⌥←` / `<prefix>⌥↓`: Resize window by `5` in direction
- `<prefix>^←` / `<prefix>^↑` / `<prefix>^←` / `<prefix>^↓`: Resize window by `1` in direction

# Layouts

- `<prefix>C-o` / `rotate-window`: Rotate windows
- `<prefix>␣` / `next-layout`: Rotate between layouts
- `<prefix>M-<number>`: Are mapped to layouts (`M-1` makes panes vertical and `M-2` makes them horizontal)

# Special

- `<prefix>z` / `resize-pane -Z`: Make pane full screen

