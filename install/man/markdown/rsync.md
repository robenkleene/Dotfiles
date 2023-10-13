# `rsync`

It's not possible for `rsync` to sync to a directory where the user does not have permissions. E.g., `rsync` does not have the capabilities to ask for a `sudo` password.

## What Gets Synced

- `rsync` checks modification dates and file sizes when it determines which files to sync.
- There's an option `-c, --checksum` that makes it only sync files that have changed by checksum, but that option makes `rsync` run significantly slower.
- `git` does not sync file modification times, so if the same `git` repo is synced from multiple clones to the same destination, everything will have to be re-synced.
- `-O, --omit-dir-times`: Ignores just directory times, which aren't important anyway.

