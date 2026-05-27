# Switching

- `<prefix>o`: Next pane
- `<prefix>;`: Last pane
- `<prefix>q`: Display pane numbers then jump to pane by number

# Moving

- `<prefix>{` / `<prefix>}`: Swap panes with pane above / below
- `<prefix>M-o`: Swap panes
- `<prefix><Space>`: Next layout

# Splitting

- `<prefix>"`: Split window horizontally
- `<prefix>%`: Split window vertically

# Closing

- `:kill-pane -a`: Kill other panes
- `<prefix>x`: Kill pane

# Joining

- `:join-pane`: Move the marked pane to the current window
- `<prefix>!`, `:break-pane`: Move pane to a new window

# Layout

- `<prefix>E`: Make panes equal size
- `<prefix>␣`, `next-layout`, `nextl` / `previous-layout`, `prevl`: Next / previous layout

## Layouts

- `<prefix>M-1`, `:select-layout even-horizontal`
- `<prefix>M-2`, `:select-layout even-vertical`
- `<prefix>M-3`, `:select-layout main-horizontal`
- `<prefix>M-4`, `:select-layout main-vertical`
- `<prefix>M-5`, `:select-layout tiled`: Equal sized tiled
- `<prefix>M-6`, `:select-layout main-horizontal-mirrored`
- `<prefix>M-7`, `:select-layout main-vertical-mirrored`

# Resizing

These can be repeated without doing the leader key (i.e., they're assigned with the `bind-key` `-r` flag).

- `<prefix>⌥←` / `<prefix>⌥↑` / `<prefix>⌥←` / `<prefix>⌥↓`: Resize pane by `5` in direction
- `<prefix>^←` / `<prefix>^↑` / `<prefix>^←` / `<prefix>^↓`: Resize pane by `1` in direction

# Marks

The marked pane is the default target for -s to `join-pane, `move-pane`, `swap-pane`, and `swap-window`.

- `<prefix>m`: Mark pane (only one pane can be marked at a time)
- `<prefix>M`: Clear marked pane

# Other

- `<prefix>>`: Show a menu with various split and kill options
- `<prefix>z` / `resize-pane -Z`: Make pane full screen
