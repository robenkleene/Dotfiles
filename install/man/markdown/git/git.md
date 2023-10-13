# `git`

## New Repo

    git remote add origin <remote-url>
    git push origin master
    git branch --set-upstream-to=origin/master master

## Common

- `git show <hash>`: Show a commit
- `git clone --depth 1 <repo>`: Clone without history
- `git clean -df`: Remove untracked

## Log

- `git log -p` (`-u`, `--patch`): Generate a patch for the commit, this is a lot like a combined `git log` and `git diff`

### File Substitution

Using file substitution with with `vimdiff`:

    vimdiff <(git show development:Cartfile) Cartfile

## Remote

- `git ls-remote --get-url`: Print just the URL

Update origin: `git remote rm origin` then `git remote add origin` with the new one.

### `git-remote`

- `--verbose` or `-v`: Print the full remote URL with additional info


## Information

- `git rev-parse HEAD`: Print current commit

## Listing Files

### `git ls-files`

- `-m` or `--modified`: List modified files
- `-o` or `--others`: List untracked and ignored files
- `--exclude-standard`: Exclude ignored files

So `git ls-files -o --exclude-standard` will list untracked files that aren't ignored.

## `git stash`

- `git stash show -p` or `git stash show --patch`: Show a `diff` of the stash
- `git stash save "My stash"`: Give a stash a name
    - Note that when using options with `save`, they must go after `save` and before the name (otherwise they'll be used as part of the name)
- `git stash -p`: Do an interactive stash
    - `y`: Stash this hunk
    - `n`: Do not stash this hunk
    - `q`: Quit and don't stash anymore

## Merge Upstream

    git merge upstream/master

## Revert to a Commit

This will make one commit that reverts to a previous commit:

    git revert --no-commit 0cb64eb7eff0827d3fea1e6c4d172b9fe85b852b..HEAD

## From a Path

- `-C`: Run a git command from a path
