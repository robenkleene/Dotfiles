%

# `magit`

- `s`: `git add`
- `k`: Discard change
- `g`: Refresh all
- `G`: Refresh

## Status

- `<M-tab>`: Cycle diff collapsed

## Commit

1. `c c`: Start commit (don't use `C`, that's what inserts an entry for the current file)
2. `C-c C-c`: Finish commit
3. `P p`: Git push

- `C-c C-k`: Cancel commit

## Basic

- `F p`: `git pull`

## Branches

- `b c`: Change branch

## Diff

- `d r <branch>`: Diff vs. a branch

## Log

- `l`: Brings up the log pop-up
    - `l G` (then `l` to execute): Perform a git log search, e.g., `git log -G <string>`
- When a commit is selected, `<return>` focuses it, whereas `<space>` views it but commits the commit log focused (so you can view other commits). When viewing commits, use `<backspace>` scrolls backward.

## Movement

- `N-p` / `N-n`: Next/previous section
- `p` / `n`: Next/previous subsection

## Advanced

### Checkout Older (Or Deleted) Version of a File

- To checkout an older version of a file, even if it has been deleted, use `magit-file-checkout`. If the cursor is at a file path (e.g., like when the cursor is on the delete file in the log entry for a commit) then that will be used as the default path. You can then use `HEAD^` for a recently deleted file.
- When viewing a diff, just hitting enter on the added or removed section will open the correct version of the file (e.g., you can accessed the version of the file that the hunk was removed -from* by hitting enter on the removed section)

### Files

- `magit-find-file`: View a file on another branch
- `magit-log-buffer-file`: View a files log
