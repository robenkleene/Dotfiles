To fix a conflict in a binary file (e.g., a binary file says `both modified`) by checking out both versions simultaneously so they can be compared in an appropriate app for the file format:

1. `cp <conflicted-file-path> <conflicted-file-new-path>`: Copy the conflicted file to a different path (so the other version can be checked out at the original file path)
2. `git checkout --theirs <conflicted-file-path>`
3. Open the two files and compare and merge
4. Make sure what we want to keep is at `<conflicted-file-path>` and anything at `<conflicted-file-new-path>` is deleted
5. `git add . && git rebase --continue`
