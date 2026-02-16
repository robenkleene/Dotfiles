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

~/.bin/md_man_lint

cd "$(dirname "$0")" || exit 1

destination_dir="$HOME/.man/man1"

if [[ "$modified" == "true" ]]; then
  while IFS= read -r; do
    # `git ls-files --modified` actually includes deleted files, so skip those
    if [[ -e "$REPLY" ]]; then
      ~/.bin/md_man_update -d "$destination_dir" -f -p "$REPLY"
    else
      ~/.bin/md_man_update -D -d "$destination_dir" -f -p "$REPLY"
    fi
  # `grep -v '/\.'` excludes hidden files/directories (e.g., `.claude/CLAUDE.md`)
  done < <( git ls-files --modified --others 'md/*.md' 'md/**/*.md' | grep -v '/\.' )
else
  # Delete all existing
  # Fish Shell only completes from `man1` (general commands), `man6` (games),
  # and `man8` (system commands)
  if [[ -d "$destination_dir" ]]; then
    find -L "$destination_dir" -name "*.1" -type f -exec rm {} +
  fi

  while IFS= read -r; do
    ~/.bin/md_man_update -d "$destination_dir" -p "$REPLY"
  # `-path '*/.*' -prune` excludes hidden files/directories (e.g., `.claude/CLAUDE.md`)
  done < <( find md/ -path '*/.*' -prune -o -type f -name "*.md" -print )
fi
