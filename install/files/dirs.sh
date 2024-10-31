#!/usr/bin/env bash

set -euo pipefail

# Files

# `.editorconfig` is only supported in directories that are children of the
# home directory. To support other directories, symlink them here.
if [[ -e "$HOME/../Shared/Max 9/" ]]; then
  if [[ ! -e "$HOME/../Shared/Max 9/.editorconfig" ]]; then
    ln -s ~/.editorconfig/ "$HOME/../Shared/Max 9/.editorconfig"
  fi
fi

# Directories

developer_path="${HOME}/Developer"
if [[ ! -e "$developer_path" ]]; then
  mkdir -p "$developer_path"
elif [[ ! -d "$developer_path" ]]; then
  echo "Error: A file exists at $developer_path and it's not a directory" >&2
  exit 1
fi

emacs_path="${HOME}/Developer/Dotfiles/emacs.d"
untitled_emacs_path="${HOME}/Developer/Dotfiles/emacs.d/untitled"
if [[ ! -L "$emacs_path" ]]; then
  if [[ ! -e "$untitled_emacs_path" ]]; then
    mkdir -p "$untitled_emacs_path"
  elif [[ ! -d "$untitled_emacs_path" ]]; then
    echo "Error: A file exists at $untitled_emacs_path and it's not a directory" >&2
    exit 1
  fi
else
    echo "Error: A file exists at $emacs_path is not a symlink" >&2
    exit 1
fi
