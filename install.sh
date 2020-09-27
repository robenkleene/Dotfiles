#!/bin/bash

set -e

cd "$(dirname "$0")" || exit 1
source_dir=`pwd`;

# Codespaces already has these files, archive the existing ones first
function cleanup_file() {
  filename="$1"
  if [[ ! -f "$filename" && ! -L "$filename" ]]; then
    mkdir "$HOME/backup"
    mv "$filename" "$HOME/backup"
  fi
}
cleanup_file "$HOME/.zshrc"
cleanup_file "$HOME/.config"
cleanup_file "$HOME/.gitconfig"

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