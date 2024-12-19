#!/usr/bin/env bash

set -euo pipefail

directories=(
    "/path/to/dir1"
    "/path/to/dir2"
    "/path/to/dir3"
)

recursive_directories=(
    "/path/to/dir1"
    "/path/to/dir2"
    "/path/to/dir3"
)

git_directories=(
    "/path/to/dir1"
    "/path/to/dir2"
    "/path/to/dir3"
)

add_dir() {
  dir="$1"
  if [[ -d "$dir" ]]; then
      zoxide add -- "$dir"
  else
      echo "Warning: $dir is not a valid directory. Skipping."
  fi
}

for dir in "${directories[@]}"; do
  add_dir "$dir"
done
