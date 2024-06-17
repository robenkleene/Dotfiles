# Copy Mode

- `Y`: Paste selection
- `M-y`: Paste selection, also copying to clipboard
- `v`: Toggle rectangle mode (so typically hit `Space` to start a selection then `v` to toggle rectangle mode)
- Note that the default search is not incremental but uses regular expressions, and the incremental search does not use regular expressions

# Commands

- `tmux show-buffer`: Show the `tmux` buffer

# Clipboard

- `:choose-buffer` / `<prefix>=`: Paste from clipboard history

# Default Mouse

With `set -g mouse on`, by default `tmux` will copy to the `tmux` buffer and then deselect. If `y` has a copy mode override that also copies to the system clipboard, then that key can be hit while holding down the mouse button to copy to the system clipboard.
