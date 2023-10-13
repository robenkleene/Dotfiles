%

# `hg` Patch

- `hg import --prefix . --no-commit -`: Import commit from STDIN
    - `hg import -`: Read a patch from STDIN
    - `hg import --no-commit -`: Read a patch from STDIN without creating a commit
- `hg diff`: Print a patch
