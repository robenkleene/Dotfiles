- Just `fzf` alone lists files recursively by default

# Shell Bindings

- `⌃T`: Fuzzy-complete file in current directory
- `^R`: Fuzzy-complete history
- `⌥C`: Fuzzy-complete directory recursively

# Examples

- `vim $(fzf)`: Edit a file
- `cd $(fzf)`: `cd` to a directory

# Flags

- `--no-sort`: Prevents sorting matches as you type
- `--preview '<preview-cmd> {}'`: Show a preview `{}` gets replaced by the match (e.g., `--preview 'git show --color=always {}'`)

# Bindings

- `⇥`: Toggle select multiple matches

## Preview

- `⇧↑` / `⇧↓`: Scroll preview window up / down

# Actions

- `{+}`: Replaced by a quoted, space-separate, list of the selected lines

# Searches

- Prefixed with `^` means result must start with
- Prefixed with `!` means result must not contain
- Suffixed with `$` means result must end with
