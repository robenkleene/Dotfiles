# `git` Revision

- `git rev-parse HEAD`: Print current revision

## Special Revisions

- `HEAD`: Current commit
- `ORIG_HEAD`: Head before a drastic change

## Relative Revisions

- `HEAD~2`: Two commits back from `HEAD` (or grandparent)
- `HEAD^2`:

## Reflog

The reflog is a chronological list of changes in `git`.

- `git reflog`: List the reflog
- `HEAD@{1}`: Reference the previous commit in the reflog
