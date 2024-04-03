# `histedit`

To squash or rebase

- `hg histedit`: Interactive history re-order

## Splitting (or Editing) a Commit

1. Use `hg histedit` and mark a commit as edit
2. Use `hg record` to selectively commit changes, including making edits before hand or making multiple commits (note that while the edit is in progress, multiple commits will be shown in the `hg log`, i.e., the old commits and the new commits replacing them, but after running `hg histedit --continue` the old commits will be cleaned up)
3. Use `hg histedit -c` (or `hg histedit --continue`) to finish
