#!/usr/bin/env bash

set -euo pipefail

# Remove blocking files, archive the existing ones first
function cleanup_file() {
  filename="$1"
  if [[ -e "$filename" && ! -L "$filename" ]]; then
    mkdir -p "$HOME/dotfiles_backup"
    mv "$filename" "$HOME/dotfiles_backup/"
  fi
}
cleanup_file "$HOME/.bashrc"
cleanup_file "$HOME/.zshrc"
cleanup_file "$HOME/.zshenv"
cleanup_file "$HOME/.config"
cleanup_file "$HOME/.gitconfig"
cleanup_file "$HOME/.gitignore"
cleanup_file "$HOME/.inputrc"
cleanup_file "$HOME/.vimrc"

cleanup_file "$HOME/Library/Scripts"
cleanup_file "$HOME/Library/Services"
