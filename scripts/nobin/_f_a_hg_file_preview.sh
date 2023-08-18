#!/usr/bin/env bash

set -euo pipefail

for input in "$@"; do
  file=${input#*[A-Z?] }
  # Trim whitespace
  file="${file#"${file%%[![:space:]]*}"}"
  file="${file%"${file##*[![:space:]]}"}"
  if [[ ${input:0:1} != "?" ]]; then
    hg diff --color=always "$file"
  else
    ~/.bin/nobin/_preview_file.sh "$file"
  fi
done
