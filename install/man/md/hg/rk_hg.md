- `hg status`
- `hg id -i`: Print commit ID
- `hg update` / `hg up`: Checkout a commit
- `hg previous` / `hg next`: Checkout previous / next commit (down / up)

# Files

- `hg add`: Add all untracked files
- `hg addremove`: Add and remove all files
- `hg rm <file>`: Remove
- `hg record`: Make partial commits

# Pull

- `hg pull`: Fetch commits (does not merge like `git`, only downloads, more like `git fetch`)

# Rebase

- `hg rebase -d master`: Get branch up-to-date with master
- `hg rebase -s . -d master`: Rebase current diff onto master

# Reverting

- `hg revert --all`: Revert all files
- `hg purge --files`: Delete all untracked files (marked by `?`)
- `hg checkout . --clean`: Checkout all changed files
- `hg revert -r <rev> filename`: Checkout version of a file from a different branch
- `hg revert filename`: Checkout a locally deleted file
- `hg up -C remote/master`: Checkout and discard all local changes
- `hg update --clean fbobjc/stable`

## Hard Rest

- `hg purge && hg checkout --clean .`

# Stash

- `hg shelve --list`: List stashed changes
- `hg unshelve`: Pop from stash
- `hg shelve -d default`: Drop default stash

# Troubleshooting

- `hg purge`: Delete untracked
- `hg reset --clean master`: Reset to branch

# Move

To clean up a `addremove` that should be a move:

1. `hg revert <oldfile>`: Checkout the old version
2. `hg rm <newfile>`: Delete the new file
3. `hg amend`: Clean up
4. `hg mv <oldfile> <newfile`
5. `hg amend`

# Other

- `hg cat --rev=<rev> <file path>`: Get file contents on another branch
- `hg journal`: List old commits
