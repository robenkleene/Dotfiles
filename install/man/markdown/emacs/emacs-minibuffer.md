- `M-p` / `M-n`: Previous / next command
- `C-g`: Cancel minibuffer
- `<SPC>`: Complete word
- `<Tab>`: Complete
- `M-v` / `M-g M-c`: Switch to the completion window
- You can focus the minibuffer just by using the usually window switching commands

# Completion Window

- The read-only bindings work here, e.g., `<SPC>` to go forward and `<BS>` to go backward
- `<Backtab>` / `<Tab>`, `p` / `n`: Previous / next match
- `z`: Kill buffer
- `M-g M-c`: Switch back to minibuffer

# Stuck Minibuffer

If the minibuffer becomes stuck with a partial command, the solution is to focus it, either with the mouse or `C-x o`, then hit `C-g`. (Note that performing another minibuffer command, e.g., `M-x C-g` will not fix it.)

This probably happens when the minibuffer has an active command and then focus is lost (e.g., when clicking into the popup from a `<partial-command>-<tab>`.
