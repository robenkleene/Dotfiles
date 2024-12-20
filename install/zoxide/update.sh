#!/usr/bin/env bash

set -euo pipefail

directories=(
  "$HOME/Developer/Archive/"
  "$HOME/Developer/Dotfiles/"
  "$HOME/Developer/Scratch/"
)

recursive_directories=(
  "$HOME/Documentation/"
  "$HOME/Developer/Dotfiles/install/man/markdown"
)

git_directories=(
  "$HOME/Developer/Projects/"
  "$HOME/Text/Projects/"
)

add_dir() {
  dir="$1"
  if [[ -d "$dir" ]]; then
    # echo "Adding $dir"
    zoxide add -- "$dir"
  else
    echo "Warning: $dir is not a valid directory. Skipping." >&2
  fi
}

declare -i count=0
for dir in "${directories[@]}"; do
  add_dir "$dir"
  count+=1
done
echo "Added $count directories"

for base_dir in "${recursive_directories[@]}"; do
  declare -i count=0
  if [[ -d "$base_dir" ]]; then
    find "$base_dir" -not -path '*/.*' -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
      add_dir "$sub_dir"
      count+=1
    done
  else
    echo "Warning: $base_dir is not a valid directory. Skipping." >&2
  fi
  echo "Added $count recursive directories from $base_dir"
done

for search_dir in "${git_directories[@]}"; do
  declare -i count=0
  if [[ -d "$search_dir" ]]; then
    find "$search_dir" -type d -name ".git" -print0 | while IFS= read -r -d $'\0' git_dir; do
      parent_dir=$(dirname "$git_dir")
      add_dir "$parent_dir"
      count+=1
    done
    add_dir "$search_dir"
  else
    echo "Warning: $search_dir is not a valid directory. Skipping." >&2
  fi
  echo "Added $count git directories from $search_dir"
done
