1. `git rebase -i <commit-to-edit>~` (the `~` at the end is to rebase commits on top of this one)
2. Make edits
3. `git add .`
4. `git commit --amend`
5. `git rebase --continue`
