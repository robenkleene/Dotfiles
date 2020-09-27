#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" || exit 1

destination_dir="$HOME/.bin"

function make_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    echo "Warning: $destination is a file and it's not a symlink" >&2
  fi
}

destination_dir="$HOME/.bin"
if [ ! -e "$destination_dir" ]; then
  mkdir "$destination_dir"
elif [ ! -d "$destination_dir" ]; then
  echo "Destination $2 exist and it's not a directory" >&2
  exit 1
fi

for file in *; do
  # Exclude this install script and directories
  if [[ $file == "install.sh" ]]; then
    continue
  fi
  if [[ $file == "tags" || $file == "TAGS" ]]; then
    continue
  fi
  if [ -d "$file" ]; then
    continue
  fi

  executable_name="${file%.*}"
  make_symlink "$file" "$destination_dir/$executable_name"
done

# Symlink the no bin directory so scripts can reference them
nobin_destintation=$destination_dir/nobin
if [ ! -e "$nobin_destintation" ]; then
  ln -s "$DIRECTORY/nobin" "$nobin_destintation"
elif [ ! -L "$nobin_destintation" ]; then
  echo "Warning: $nobin_destintation is a file and it's not a symlink" >&2
fi

# Cleanup dead symlinks
cd "$destination_dir" &&
  find -L . -name . -o -type d -prune -o -type l -exec rm {} +
