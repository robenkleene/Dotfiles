# Basic

- `hg show`: Shows latest committed diff (excluding working directory changes)

# Other

- `hg show --stat`: Show just filenames modified
- `hg show <rev> <file-path>`: Show changes to file at revision
- `hg show . <file-path>`: Show changes to file at current
- `hg show .^1`: Show changes at previous commit
- Use `hg cat` to show the contents of a file, e.g., `hg cat <file-path> -r <rev>`
