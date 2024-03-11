- `git stash show -p` or `git stash show --patch`: Show a `diff` of the stash
- `git stash save "My stash"`: Give a stash a name
    - Note that when using options with `save`, they must go after `save` and before the name (otherwise they'll be used as part of the name)
- `git stash -p`: Do an interactive stash
    - `y`: Stash this hunk
    - `n`: Do not stash this hunk
    - `q`: Quit and don't stash anymore
- `git stash show -p`: Show a diff of the git stash

## Merge

- `git reset --merge`: Abort a git stash pop
