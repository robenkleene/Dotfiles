- `C-x k`: Kill buffer
- `C-x C-b`: List buffers
- `C-x C-f`: Find file (future history with `M-n` will be populated with the file at point)
- `C-x 4 C-f`: Find file other window
- `C-x 5 C-f`: Find file other frame
- `C-x C-s`: Save buffer
- `C-x s`: Prompt to save all modified buffers

# State Restoration

- `M-x desktop-clear`: Closes open buffers

# Open Recent

- `C-x C-f`, or `M-x find-file-at-point` has a history that contains all recent files (if `recentf-mode` is enabled). It can be accessed either by using the up and down arrow keys, or by using incremental search (`C-s` or `C-r`, the latter being a particularly fast way to access previous files).
- `C-x C-f` populates with the current location by default, you can usually just ignore this and paste in a relative path to edit it, or type `~` or `/` to edit a file relative to one of those paths.
