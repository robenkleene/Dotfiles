#!/usr/bin/env bash

set -euo pipefail

while read -r filename; do
  filename=$(basename "$filename")
  filename_no_ext=${filename%.*}
  if [[ $filename_no_ext =~ ^[a-z0-9_-]*$ ]]; then
    # If the filename contains only lowercase letters, hyphens, and underscores then assume
    # convert it to title case with hyphens and underscores replaced with spaces.
    # For hyphens, only convert if both sides aren't numbers, e.g., so `2024-12-19` gets preserved
    # 's/([0-9]+)-([^0-9]+)/\1 \2/g' replace digits on one side with spaces (e.g., replace the hyphen in `123-abc`)
    # 's/([^0-9]+)-([0-9]+)/\1 \2/g' replace digits on the other side with spaces (e.g., replace the hyphen in `abc-123`)
    # 's/([^0-9]+)-([^0-9]+)/\1 \2/g' replace digits on the neither side with spaces (e.g., replace the hyphen in `abc-abc`)
    # Using Perl because macOS `sed` doesn't support non-greedy matches with `?`
    title=$(echo "$filename_no_ext" | perl -pe 's/([0-9]+?)-([^0-9]+?)/\1 \2/g' | perl -pe 's/([^0-9]+?)-([0-9]+?)/\1 \2/g' | perl -pe 's/([^0-9]+?)-([^0-9]+?)/\1 \2/g' | tr "_" " " | ~/.bin/f_titlecase)
  else
    title=$(echo "$filename_no_ext" | ~/.bin/f_titlecase)
  fi
  echo "$title"
done
