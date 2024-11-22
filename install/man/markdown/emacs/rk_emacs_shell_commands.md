- `C-u M-!`: Insert the result of a shell command at the point (this doesn't use the region)
    - With `(setq enable-recursive-minibuffers t)`, this can also be used within the minibuffer (e.g., `C-u M-! today` to insert today, `M-! "<backtick>today<backtick>"` also works)
- `M-!` / `shell-command`: Run a shell command displaying the result in a separate buffer, to run this on the current file (hit `M-n` in the minibuffer for future history match to populate with the current file)
- `M-! M-n`: Run a shell command on the current file
- `M-|` / `shell-command-on-region`: Run a shell command on the region (output is printed to the minibuffer)
- `C-u M-|`: Run a shell command on the region, replacing region