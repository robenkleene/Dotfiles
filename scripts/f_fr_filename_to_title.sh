#!/usr/bin/env bash

set -euo pipefail

while read -r filename; do
  filename=$(basename "$filename")
  filename_no_ext=${filename%.*}
  if [[ $filename_no_ext =~ ^[a-z0-9_-]*$ ]]; then
    # If the filename contains only lowercase letters, hyphens, and underscores then assume
    # convert it to title case with spaces.
    title=$(echo "$filename_no_ext" | tr "-" " " | tr "_" " " | ~/.bin/f_titlecase)
  else
    title=$(echo "$filename_no_ext" | ~/.bin/f_titlecase)
  fi
  echo "$title"
done
