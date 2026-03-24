# `histedit`

To squash or rebase

- `hg histedit`: Interactive history re-order

## Splitting (or Editing) a Commit

1. Use `hg histedit` and mark a commit as edit
2. Use `hg record` to selectively commit changes, including making edits before hand or making multiple commits (note that while the edit is in progress, multiple commits will be shown in the `hg log`, i.e., the old commits and the new commits replacing them, but after running `hg histedit --continue` the old commits will be cleaned up)
3. Use `hg histedit -c` (or `hg histedit --continue`) to finish

- Doing `hg histedit --continue` with uncommitted changes will apply those changes to the commit being edited (e.g., to split a commit, you can first commit some files with `hg record` then just do `hg histedit --continue` to add the remaining changes to the commit being edited)
- Doing `hg record --amend` will apply any changes to the *commit before being edited* (this is the current commit in `hg log`), so you can add some changes from the commit being edited to the previous commit with `hg record --amend`
