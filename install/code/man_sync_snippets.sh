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

make_snippets() {
  src="$1"
  lang=$(basename "${src%.*}")
  if [[ "$lang" = "javascript" ]]; then
    lang="js"
  elif [[ "$lang" = "shellscript" ]]; then
    lang="bash"
  elif [[ "$lang" = "objective-c" ]]; then
    lang="objc"
  fi
  if [[ "$lang" != "package" && "$lang" != "global" ]]; then
    dst="$dst_dir/rk_lang_${lang}_snippets.md"
    ./snippet_to_md.sh "$src" "$dst"
  fi
}

dst_dir="../man/markdown/snippets"
src_dir="$HOME/.config/Code/User/snippets"
if [[ ! -e "$dst_dir" ]]; then
  mkdir -p "$dst_dir"
fi

if [[ "$modified" == "true" ]]; then
  while IFS= read -r; do
    # `git ls-files --modified` actually includes deleted files, so skip those
    if [[ -e "$REPLY" ]]; then
      src="$REPLY"
      make_snippets "$src"
    fi
  done < <( git ls-files --modified --others '$src_dir/*.json' )
else
  # Delete all existing
  # Fish Shell only completes from `man1` (general commands), `man6` (games),
  # and `man8` (system commands)
  if [[ -d "$dst_dir" ]]; then
    find -L "$dst_dir" -name "*.md" -type f -exec rm {} +
  fi

  while IFS= read -r; do
    src="$REPLY"
    make_snippets "$src"
  done < <( find "$src_dir" -type f -name "*.json" )
fi
