%

# `emacs` Window Management

- `C-x C-space` or `C-x C-@`: Return to previous position

## Buffers

- `C-x <left>` / `C-x <right>`: Go to previous / next buffer
- `C-x k`: Kill buffer

## Frames

- `C-x 5 2`: Create a new frame
- `C-x 5 0`: Delete current frame
- `C-x 5 1` / `delete-other-frames`: Delete all frames except the current
- `C-x 5 o`: Cycle through frames
- `C-x ←` or `C-x →`: Next or previous buffer

## Windows

- `C-x 0`: Close window
- `C-x o`: Next window
- `C-- C-x o`: Previous Window (note that `C--` doesn't seem to work on OS X Terminal, but `M--` is mapped to the same function `negative-argument`)
- `C-x 1`: Close other windows
- `C-x 2`: Split window horizontally
- `C-x 3`: Split window vertically
- `C-x +`: Make window equal size

## Tabs

- `C-x t 2`: Create new tab
- `C-x t O` / `C-x t o`: Go to previous / next tab
- `C-x t 0`: Close tab
- `C-x t 1`: Close other tabs

## Other Window

- `C-M-v` / `S-C-M-v`: Page down / up in other window (note page up doesn't work in terminal Emacs)
- `C-u - C-M-v` / `M-- C-M-v`: Page up in other window (works in terminal emacs)

## Window Configurations

- `C-c ←` or `C-c →`: With `winner-mode` enabled, previous/next configuration
