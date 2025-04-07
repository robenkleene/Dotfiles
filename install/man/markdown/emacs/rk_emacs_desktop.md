- `desktop-save`: Prompt for a filename to save 
- `desktop-save-mode`: Turn on a mode that automatically saves

# Save Location

- `desktop-dirname`: defaults to `user-emacs-directory` (`~/.emacs.d`)
- `desktop-base-file-name`: defaults to `.emacs.desktop`

# Restore Desktop

1. `desktop-save-mode` to save on quit, or `desktop-save` to save now (prompting for a location)
2. Quit Emacs
3. `desktop-read`
