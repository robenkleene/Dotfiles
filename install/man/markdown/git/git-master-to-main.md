# `git` Master to Main

- Rename the main branch from `master` to `main` on GitHub, by going to branches, then clicking the edit button next to the branch.

## Updating Local Checkouts

    # Move master to main
    git branch -m master main
    # Get up to date with origin
    git fetch origin
    # Push to the upstream branch
    git branch -u origin/main main
    # Update `refs/remotes/origin/HEAD` to point to the default branch
    git remote set-head origin -a

    git branch -m master main
    git fetch origin
    git branch -u origin/main main
    git remote set-head origin -a

