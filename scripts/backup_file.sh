#!/usr/bin/env bash

set -e

backup_root_directory=~/Archive/Text/

for filepath in "$@"; do
  filepath=$filepath
  filename=$(basename "$filepath")
  if [[ ! -e "$filepath" ]]; then
    echo "No valid file at $filepath"
    exit 1
  fi
  filename_no_ext=${filename%.*}
  if [[ -z "$filename_no_ext" ]]; then
    echo "No valid filename found for $filepath"
    exit 1
  fi
  today=$(date +%Y-%B-%d)
  backup_directory=$backup_root_directory$today
  mkdir -p "$backup_directory"
  archive_file=$(mktemp "$backup_directory/$today-$filename_no_ext.XXXX")
  destination_archive_file=$archive_file.md
  rm "$archive_file"

  mv -n "$filepath" "$destination_archive_file"
  if [[ -f "$filepath" ]]; then
    echo -n "$filepath"
  else
    echo -n "$destination_archive_file"
  fi
done
