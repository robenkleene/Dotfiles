# Creating

- `<prefix>c`, `new-window -a`: Create window
- `<prefix>&`: Kill window
- `:kill-window -a`: Kill other windows

# Switching

- `<prefix>w`: Window picker
- `<prefix>l`: Last window
- `<prefix>p`: Previous window
- `<prefix>n`: Next window
- `<prefix>0`, `<prefix>1`...: Switch to that window number
- `<prefix>'`: Switch to window (Prompt to enter window number)

# Moving

- `<prefix>.`: Move the current window to a session (session names can be tab completed)
- `swap-window -t -1` / `swap-window -t +1`: Swap window left / right
- `<prefix>C-o` / `rotate-window`: Rotate windows
- `swap-window -s 3 -t 1`: Move window index 3 to a used index
- `swap-window -t 1`: Move current window to a used index
- `:movew`: Move window to next unused window number
- `:movew -r`: Move all windows to next unused window number

# Renaming

- `<prefix>,`: Rename Window
