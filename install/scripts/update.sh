#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" || exit 1
src_dir="$(pwd -P)/bin"
dest_dir="$HOME/.bin"

function make_symlink() {
  src="$1"
  dest="$2"
  if [ ! -e "$dest" ]; then
    ln -s "$src" "$dest"
  elif [ ! -L "$dest" ]; then
    echo "Warning: $dest is a file and it's not a symlink" >&2
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
  if [[ $(basename "$file") == "tags" || $(basename "$file") == "TAGS" ]]; then
    continue
  fi
  if [ -d "$file" ]; then
    continue
  fi

  exec_name=$(basename "${file%.*}")
  chmod a+x "$file"
  make_symlink "$file" "$dest_dir/$exec_name"
done

# Symlink the no bin directory so scripts can reference them
nobin_dest=$dest_dir/nobin
if [ ! -e "$nobin_dest" ]; then
  ln -s "$src_dir/nobin" "$nobin_dest"
elif [ ! -L "$nobin_dest" ]; then
  echo "Warning: $nobin_dest is a file and it's not a symlink" >&2
fi
