If a commit needs to be updated replacing `hg rm` then `hg add` by replacing it with a `hg mv`:

- `hg mv <old-file> <new-file> --mark --amend`: Resolve the issue in a single command

# Manual Steps

1. `cp` all the files back to their original locations
2. `hg mv` all the files to their new locations
3. `hg addr`
4. `hg amend`