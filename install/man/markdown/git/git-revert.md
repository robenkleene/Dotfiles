%

# `git` Revert

To revert a commit, but not create a commit, e.g., just leave the changes in the working directory, use the following command:

    git show <rev> | git apply -R
