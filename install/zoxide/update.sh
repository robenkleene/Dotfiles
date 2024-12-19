#!/usr/bin/env bash

set -euo pipefail

# List of directories to add to zoxide
directories=(
    "/path/to/dir1"
    "/path/to/dir2"
    "/path/to/dir3"
)

# Iterate through each directory and call `zoxide add`
for dir in "${directories[@]}"; do
    if [[ -d "$dir" ]]; then
        zoxide add -- "$dir"
        echo "Added $dir to zoxide."
    else
        echo "Warning: $dir is not a valid directory. Skipping."
    fi
done
