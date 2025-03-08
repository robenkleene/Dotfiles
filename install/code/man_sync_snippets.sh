#!/usr/bin/env bash

set -euo pipefail

modified="false"
while getopts ":mh" option; do
  case "$option" in
    m)
      modified="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

cd "$(dirname "$0")" || exit 1

destination_dir="../man/markdown/snippets/"
source_dir="~/.config/Code/User/snippets"

if [[ "$modified" == "true" ]]; then
  while IFS= read -r; do
    # `git ls-files --modified` actually includes deleted files, so skip those
    if [[ -e "$REPLY" ]]; then
      src="$REPLY"
      lang=$(basename "${src%.*}")
      dst="$destination_dir/rk_snippets_${lang}.md"
      ./snippet_to_md.sh "$src" "$dst"
    fi
  done < <( git ls-files --modified --others '$destination_dir/*.json' )
else
  # Delete all existing
  # Fish Shell only completes from `man1` (general commands), `man6` (games),
  # and `man8` (system commands)
  if [[ -d "$destination_dir" ]]; then
    find -L "$destination_dir" -name "*.md" -type f -exec rm {} +
  fi

  while IFS= read -r; do
    src="$REPLY"
    lang=$(basename "${src%.*}")
    dst="$destination_dir/rk_snippets_${lang}.md"
    ./snippet_to_md.sh "$src" "$dst"
  done < <( find markdown -type f -name "*.md" )
fi
