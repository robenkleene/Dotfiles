# `git` Branch

## Rename

- `git branch -m <newname>`: Rename the current branch
- `git branch -m <oldname> <newname>`: Rename a specific branch by name

## Remote

- `git branch -r`: List remote branches (`git fetch` first to make sure all the branches are listed)
- `git branch -vv`: See which remote branch a local branch is tracking
- `git remote prune origin`: Delete remote branches that no longer exist

## Delete

- `-d` / `--delete`: Delete a branch
- `git push origin --delete`: Delete remote branch
