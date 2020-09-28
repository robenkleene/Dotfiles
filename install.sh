#!/bin/bash

set -e

cd "$(dirname "$0")" || exit 1
source_dir=$(pwd -P);

# Codespaces already has these files, archive the existing ones first
function cleanup_file() {
  filename="$1"
  if [[ -e "$filename" && ! -L "$filename" ]]; then
    mkdir -p "$HOME/backup"
    mv "$filename" "$HOME/backup/"
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
    echo "Warning: $destination exists and it's not a symlink" >&2
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

developer_path="${HOME}/Developer"
if [[ ! -e "$developer_path" ]]; then
  mkdir -p "$developer_path"
elif [[ ! -d "$developer_path" ]]; then
  echo "Error: A file exists at $developer_path and it's not a directory" >&2
  exit 1
fi

# TODO: When GitHub Codespaces supports SSH keys, install private repos via Settings
# settings_path="${developer_path}/Settings"
# if [[ ! -e "$settings_path" ]]; then
#   mkdir -p "$settings_path"
# elif [[ ! -d "$settings_path" ]]; then
#   echo "Error: A file exists at $settings_path and it's not a directory" >&2
#   exit 1
# fi
