- `C-x C-space` or `C-x C-@`: Return to previous position

# Buffers

- `C-x <left>` / `C-x <right>`: Go to previous / next buffer (note that buffer history in Emacs not replaced when opening a split, e.g., when calling `split-window`, and then going to the previous buffer in the new split, will open the last buffer that was open in the new split, not the previous buffer in from the original split)
- `C-x k`: Kill buffer

# Frames

- `C-x 5 2`: Create a new frame
- `C-x 5 0`: Delete current frame
- `C-x 5 1` / `delete-other-frames`: Delete all frames except the current
- `C-x 5 o`: Cycle through frames
- `C-x ←` or `C-x →`: Next or previous buffer

# Windows

- `C-x 0`: Close window
- `C-x o`: Next window
- `C-- C-x o`: Previous Window (note that `C--` doesn't seem to work on OS X Terminal, but `M--` is mapped to the same function `negative-argument`)
- `C-x 1`: Close other windows
- `C-x 2`: Split window horizontally
- `C-x 3`: Split window vertically
- `C-x +`: Make window equal size

# Tabs

- `C-x t r`: Rename tab
- `C-x t 2`: Create new tab
- `C-x t O` / `C-x t o`: Go to previous / next tab
- `C-x t 0`: Close tab
- `C-x t 1`: Close other tabs

# Buffers

- `C-x <left>` / `C-x <right>`: Go to previous / next buffer

# Other Window

- `M-<pageup>`, `S-C-M-v` / `M-<pageup>`, `C-M-v`: Page up / down in other window (note `S-C-M-v` doesn't work in terminal Emacs)
- `C-u - C-M-v` / `M-- C-M-v`: Page up in other window (works in terminal emacs)

# Window Configurations

- `C-c ←` or `C-c →`: With `winner-mode` enabled, previous/next configuration

# Cursor

- `C-l`: Center cursor

# Display Buffer

See help for `display-buffer`.

Focusing a specific buffer.

```
(add-to-list
 'display-buffer-alist
 '("\\*rg\\*" . (nil . ((body-function . select-window)))))
```

- `(nil . ((body-function . select-window)))` is the `ACTION` which is `(FUNCTIONS . ALIST)`, since `FUNCTIONS` is `nil` it will go to `display-buffer-base-action` and `display-buffer-fallback-action`.
- `ALIST` is `((body-function . select-window))` `body-function` is a function called with one argument, the displayed window.
