%

# `hg`

- `hg status`
- `hg amend`: Amend last commit (`hg` has no staging)
- `hg id -i`: Print commit ID
- `hg update`: Checkout a commit

## Files

- `hg add`: Add all untracked files
- `hg addremove`: Add and remove all files
- `hg rm <file>`: Remove
- `hg record`: Make partial commits

## Pull

- `hg pull`: Fetch commits (does not merge like `git`, only downloads, more like `git fetch`)

## Rebase

- `hg rebase -d master`: Get branch up-to-date with master
- `hg rebase -s . -d master`: Rebase current diff onto master

## Reverting

- `hg revert --all`: Revert all files
- `hg purge --files`: Delete all untracked files (marked by `?`)
- `hg checkout . --clean`: Checkout all changed files
- `hg revert -r <rev> filename`: Checkout version of a file from a different branch
- `hg revert filename`: Checkout a locally deleted file
- `hg up -C remote/master`: Checkout and discard all local changes
- `hg update --clean fbobjc/stable`

### Hard Rest

- `hg purge && hg checkout --clean .`

### Reverting Reverts

- `hg backout <reverting diff>`

## Conflicts

- `hg resolve --all`: Resolve all merge conflicts

## Workflow

- `hg log -pr .`: Show last commit
- `hg backout -r .`: Revert last commit

## Stash

- `hg shelve --list`: List stashed changes
- `hg unshelve`: Pop from stash
- `hg shelve -d default`: Drop default stash

## Troubleshooting

- `hg purge`: Delete untracked
- `hg reset --clean master`: Reset to branch

## `histedit`

To squash or rebase

- `hg histedit`: Interactive history re-order
- `hg resolve -t internal:other --all`: Accept theirs
- `hg resolve -t internal:local --all`: Accept ours

### Split a Commit

Or edit

1. Use `hg histedit` and mark a commit as edit
2. Use `hg record` to selectively commit changes, including making edits before hand or making multiple commits
3. Use `hg histedit --continue` to finish

## Move

To clean up a `addremove` that should be a move:

1. `hg revert <oldfile>`: Checkout the old version
2. `hg rm <newfile>`: Delete the new file
3. `hg amend`: Clean up
4. `hg mv <oldfile> <newfile`
5. `hg amend`

## Other

- `hg cat --rev=<rev> <file path>`: Get file contents on another branch
- `hg log -r "<commit>::."`: Check if a commit (`<commit>`) is an ancestor of the current commit (`.`)
- `hg journal`: List old commits
