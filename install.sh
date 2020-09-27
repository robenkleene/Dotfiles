#!/bin/bash

set -e

cd "$(dirname "$0")" || exit 1
source_dir=`pwd`;

function make_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    echo "Warning: $destination is a file and it's not a symlink" >&2
  fi
}

for file in *; do
  if [[ $file == *.sh ]]; then
    continue
  fi
  if [[ $file == "scripts" ]]; then
    continue
  fi
  if [[ $file == "tags" || $file == "TAGS" ]]; then
    continue
  fi

  make_symlink "$source_dir/$file" "$HOME/.$file"
done

./scripts/install.sh