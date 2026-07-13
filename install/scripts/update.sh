#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" || exit 1
src_dir="$(pwd -P)/bin"
dest_dir="$HOME/.bin"

# This doesn't use `source ~/.bin/nobin/_rk-symlink.sh` so that the
# `safe_symlink` function is available before this script has been run for the
# first time.
function safe_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    if [ "$destination" != "$source" ]; then
      echo "Warning: $destination exists and does not link to $source" >&2
    fi
  fi
}

if [ ! -e "$dest_dir" ]; then
  mkdir "$dest_dir"
elif [ ! -d "$dest_dir" ]; then
  echo "Dest $dest_dir exist and it's not a directory" >&2
  exit 1
fi

# Cleanup dead symlinks
cd "$dest_dir" &&
  find -L . -name . -o -type d -prune -o -type l -exec rm {} +

for file in "$src_dir"/*; do
  name="${file##*/}"
  if [[ "$name" == "tags" || "$name" == "TAGS" ]]; then
    continue
  fi
  if [ -d "$file" ]; then
    continue
  fi

  exec_name="${name%.*}"
  chmod a+x "$file"
  safe_symlink "$file" "$dest_dir/$exec_name"
done

# Symlink the no bin directory so scripts can reference them
nobin_dest=$dest_dir/nobin


safe_symlink "$src_dir/nobin" "$nobin_dest"
