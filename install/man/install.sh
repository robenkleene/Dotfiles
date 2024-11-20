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

if [[ "$modified" == "true" ]]; then
  while IFS= read -r; do
    ~/.bin/md_man_update -f -p "$REPLY"
  done < <( git ls-files --modified --others 'markdown/**/*.md' )
else
  # Delete all existing
  destination_dir="$HOME/.man/man9"
  if [[ -d "$destination_dir" ]]; then
    find -L "$destination_dir" -name "*.9" -type f -exec rm {} +
  fi

  while IFS= read -r; do
    ~/.bin/md_man_update -p "$REPLY"
  done < <( find markdown -type f -name "*.md" )
fi
