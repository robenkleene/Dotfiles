- `kill-emacs`: Kill server without prompting
- `save-buffers-kill-emacs`: Save buffers and kill

# Command-Line

- `emacsclient -e '(save-buffers-kill-emacs)'`
- `emacsclient -e '(save-buffers-kill-emacs t)'`
- `emacsclient -e '(kill-emacs)'`

# Notes

- There isn't a way to automatically connect to the Emacs server with GUI Emacs.
