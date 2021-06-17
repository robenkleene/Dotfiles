#!/usr/bin/env bash

set -euo pipefail

developer_path="${HOME}/Developer"
if [[ ! -e "$developer_path" ]]; then
  mkdir -p "$developer_path"
elif [[ ! -d "$developer_path" ]]; then
  echo "Error: A file exists at $developer_path and it's not a directory" >&2
  exit 1
fi


emacs_path="${HOME}/Developer/Dotfiles/emacs.d"
untitled_emacs_path="${HOME}/Developer/Dotfiles/emacs.d"
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
