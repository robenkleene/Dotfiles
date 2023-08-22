#!/usr/bin/env bash

set -euo pipefail

for input in "$@"; do
  file=${input#*[A-Z?] }
  # Trim whitespace
  file="${file#"${file%%[![:space:]]*}"}"
  file="${file%"${file##*[![:space:]]}"}"
  if [[ ${input:0:2} = " M" ]]; then
    eval git add "$file"
  elif [[ ${input:0:2} = "MM" ]]; then
    eval git add "$file"
  elif [[ ${input:0:2} = " D" ]]; then
    eval git rm "$file"
  elif [[ ${input:0:2} = "??" ]]; then
    eval git add "$file"
  else
    eval git restore --staged "$file"
  fi
done
