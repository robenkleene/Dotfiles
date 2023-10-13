%

# `git diff`

- `git diff --relative`: Relative diff
- `git diff --word-diff`: Diff by words
- `git diff HEAD^1`: Only changes in most recent revision

## Branch Comparison Strategy

- Use `git diff --name-status master` to list the files that have been added, changed, or removed.
- Use `git difftool master -- <file path>` (defaults to `vimdiff`) to view side-by-side versions of a file. Note that this works even if the file has been deleted from the working tree, this can be useful to get syntax highlighting.
- Use `git show master:<file path>` to show the contents of a file. Note that this doesn't have syntax highlighting, `bat` can be used to add syntax highlighting (e.g., `git git show master:<file path> | bat -lswift`).
- Use `git grep <search term> master` to search a different branch
