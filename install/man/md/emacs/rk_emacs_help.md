- `C-h o`: Describe symbol (this includes both functions and variables, it's useful for describing the thing at point)
- `C-h k`: Tell what a key does (describe-key)
- A prefix key (e.g., `M-s`) followed by `C-h` will show all bindings with that prefix
- `C-h f` (`describe-function`): Describe function, also shows key bindings
- `C-h m`: Key bindings for current mode
- `C-h l` or `M-x view-lossage`: Show incoming key presses to make sure they're making it to `emacs`
- `C-h b`: Show all bindings

# Help Mode

- `l` / `C-c C-b` / `help-go-back`: Go to previous help topic
- `r` / `C-c C-b` / `help-go-forward`: Go to next help topic
- `<TAB>` or `forward-button`: Go to next button
- `S-<TAB>` or `back-button`: Go to next button

## Notes

Scrolling in the other window is helpful for help buffers.

- `M-<pageup>`, `S-C-M-v` / `M-<pageup>`, `C-M-v`: Page up / down in other window (note `S-C-M-v` doesn't work in terminal Emacs)

# Minibuffer

- From `M-x`, `C-h f` will show help for the current function
