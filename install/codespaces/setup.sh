#!/usr/bin/env bash

set -euo pipefail

# Codespaces already has these files, archive the existing ones first
function cleanup_file() {
  filename="$1"
  if [[ -e "$filename" && ! -L "$filename" ]]; then
    mkdir -p "$HOME/backup"
    mv "$filename" "$HOME/backup/"
  fi
}
cleanup_file "$HOME/.bashrc"
cleanup_file "$HOME/.zshrc"
cleanup_file "$HOME/.config"
cleanup_file "$HOME/.gitconfig"
