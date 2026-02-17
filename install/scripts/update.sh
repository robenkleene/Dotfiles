#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" || exit 1
src_dir="$(pwd -P)/bin/";

dest_dir="$HOME/.bin/"

function make_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    echo "Warning: $destination is a file and it's not a symlink" >&2
  fi
}

dest_dir="$HOME/.bin/"
if [ ! -e "$dest_dir" ]; then
  mkdir "$dest_dir"
elif [ ! -d "$dest_dir" ]; then
  echo "Destination $dest_dir exist and it's not a directory" >&2
  exit 1
fi

# Cleanup dead symlinks
cd "$dest_dir" &&
  find -L . -name . -o -type d -prune -o -type l -exec rm {} +

for file in "$src_dir"*; do
  if [[ $file == "tags" || $file == "TAGS" ]]; then
    continue
  fi
  if [ -d "$file" ]; then
    continue
  fi

  executable_name=$(basename "${file%.*}")
  chmod a+x "$file"
  make_symlink "$file" "$dest_dir/$executable_name"
done

# Symlink the no bin directory so scripts can reference them
nobin_destintation=$dest_dir/nobin
if [ ! -e "$nobin_destintation" ]; then
  ln -s "$src_dir/nobin" "$nobin_destintation"
elif [ ! -L "$nobin_destintation" ]; then
  echo "Warning: $nobin_destintation is a file and it's not a symlink" >&2
fi
