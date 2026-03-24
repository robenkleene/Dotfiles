- `git stash show -p` or `git stash show --patch`: Show a `diff` of the stash
- `git stash save <stash-name>`: Save a named stash (Note that when using options with `save`, they must go after `save` and before the name (otherwise they'll be used as part of the name)

## Interactive Stash

- `git stash -p`: Start an interactive stash

### Interactive Stash Bindings

- `y`: Stash this hunk
- `n`: Do not stash this hunk
- `q`: Quit and don't stash anymore

## Merging

- `git reset --merge`: Abort a git stash pop
