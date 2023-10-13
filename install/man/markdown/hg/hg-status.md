%

# `hg` Status

- `hg status --change .`: List uncommitted changed files
- `hg status --change bottom^`: List changed files on current branch
- `hg status --rev bottom^`: List all changed files on current branch
- `hg status --rev bottom^ -n`: Omit the per file statuses
- `hg status --rev .^1 -mn`: List just changed files at revision
