%

# `git` Checkout

- `git checkout master -- <path>`: Checkout a file from another branch, note this adds it to the index (`git reset` removes all files from the index)
- `git checkout <commit>^1 -- <path>`: Checkout a file that was deleted at commit `<commit>` (note we need to use `^1` to get from the revision before the file was deleted)
