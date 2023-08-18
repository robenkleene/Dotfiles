#!/usr/bin/env bash

set -euo pipefail

while IFS= read -r input; do
  file=${input#*[A-Z?] }
  # Trim whitespace
  file="${file#"${file%%[![:space:]]*}"}"
  file="${file%"${file##*[![:space:]]}"}"
  if [[ ${input:0:1} = "M" ]]; then
    git add "$file"
  else
    git restore --staged "$file"
  fi
done
