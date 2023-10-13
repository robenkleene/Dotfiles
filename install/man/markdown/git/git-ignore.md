%

# `git` Ignore

- `git clean -dfX`: Delete all ignored files

## Ignored Files

List ignored files:

    git ls-files -c --ignored --exclude-standard

Remove all ignored files:

    git ls-files -c --ignored --exclude-standard -z | xargs -0 git rm --cached
