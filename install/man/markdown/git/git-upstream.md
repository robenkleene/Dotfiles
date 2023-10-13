# `git` Upstream

1. Check if `upstream` is set with `git remote -v`
2. If it's not, set it with `git remote add upstream <repo-url>`
3. `git fetch upstream` to get upstream changes locally
4. Review upstream changes with `git log upstream/master`
5. Merge in upstream changes:

        git checkout main
        git merge upstream/main

    *Probably `git rebase upstream/master` is better?*
