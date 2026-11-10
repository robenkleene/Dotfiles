- `~` / `<F1>`: Show help
- `.`: Toggle hidden
- `Q`: Exit without writing `cwd` file (stay in current directory)
- `:`: Run shell command (e.g., `mkdir "$(today) archive"`)

# Navigation

- `z`: Jump to a file or directory with `fzf`
- `Z`: Jump to a directory with `zoxide`
- `H` / `L`: Go to previous / next directory

# CLI

- `yazi --debug`: Show config file paths, the detected terminal, and the image adapter (e.g., to troubleshoot image previews)
- `yazi --clear-cache`: Clear the cache of resized image previews (e.g., after changing the preview `max_width` / `max_height` in `yazi.toml`, since old previews stay cached at the previous size)
