To fix an `hg rm` then `hg add` by replacing it with a `hg mv`:

1. `cp` all the files back to their original locations
2. `hg mv` all the files to their new locations
3. `hg addr`
4. `hg amend`