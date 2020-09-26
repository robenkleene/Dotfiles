#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" || exit 1

destination_dir="$HOME/.bin"

function make_symlink() {
  source=.$1
  destination=~/.$1
  if [ !-e "$destination" ]; then
    echo "ln -s $source $destination"
    #    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    echo "ERROR: $destination is a file and it's not a symlink!"
  fi
}

shopt -s nullglob
for thisFILE in *; do
  # Exclude this install script and directories
  if [[ ! $thisFILE == "install.sh" ]] &&
    [[ ! $thisFILE == "TAGS" ]] &&
    [[ ! $thisFILE == "tags" ]] &&
    [ ! -d "$thisFILE" ]; then
    make_symlink "$thisFILE"
  fi
done

# Symlink the no bin directory so scripts can reference them
nobin_destintation=$destination_dir/nobin
if [ ! -e "$nobin_destintation" ]; then
  # ln -s "$DIRECTORY/nobin" "$nobin_destintation"
  echo "ln -s "./nobin" $nobin_destintation"
elif [ ! -L "$nobin_destintation" ]; then
  echo "ERROR: $nobin_destintation is a file and it's not a symlink!"
fi

# Cleanup dead symlinks
cd "$destination_dir" &&
  find -L . -name . -o -type d -prune -o -type l -exec rm {} +
