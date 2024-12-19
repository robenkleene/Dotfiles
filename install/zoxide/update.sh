#!/usr/bin/env bash

set -euo pipefail

directories=(
  "$HOME/Developer/Archive/"
  "$HOME/Developer/Dotfiles/"
)

recursive_directories=(
  "$HOME/Developer/Scratch/"
)

git_directories=(
  "$HOME/Documentation/"
  "$HOME/Developer/Projects/"
  "$HOME/Text/"
)

add_dir() {
  dir="$1"
  if [[ -d "$dir" ]]; then
    echo "Adding $dir"
    # zoxide add -- "$dir"
  else
    echo "Warning: $dir is not a valid directory. Skipping."
  fi
}

for dir in "${directories[@]}"; do
  add_dir "$dir"
done

for base_dir in "${recursive_directories[@]}"; do
  if [[ -d "$base_dir" ]]; then
    find "$base_dir" -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
      add_dir "$sub_dir"
    done
  else
    echo "Warning: $base_dir is not a valid directory. Skipping."
  fi
done

for search_dir in "${git_directories[@]}"; do
  if [[ -d "$search_dir" ]]; then
    find "$search_dir" -type d -name ".git" -print0 | while IFS= read -r -d $'\0' git_dir; do
      parent_dir=$(dirname "$git_dir")
      add_dir "$parent_dir"
    done
    add_dir "$search_dir"
  else
    echo "Warning: $search_dir is not a valid directory. Skipping."
  fi
done
