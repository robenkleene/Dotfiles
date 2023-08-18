#!/usr/bin/env bash

set -euo pipefail

for input in "$@"; do
  file=${input#*[A-Z?] }
  # Trim whitespace
  file="${file#"${file%%[![:space:]]*}"}"
  file="${file%"${file##*[![:space:]]}"}"
  if [[ ${input:0:2} = " M" ]]; then
    git add "$file"
  elif [[ ${input:0:2} = "MM" ]]; then
    git add "$file"
  else
    git restore --staged "$file"
  fi
done
