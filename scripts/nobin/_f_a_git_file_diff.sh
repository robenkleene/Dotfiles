#!/usr/bin/env bash

set -euo pipefail

for input in "$@"; do
  file=${input#*[A-Z?] }
  # Trim whitespace
  file="${file#"${file%%[![:space:]]*}"}"
  file="${file%"${file##*[![:space:]]}"}"
  if [[ ${input:0:1} = "?" ]]; then
    eval ~/.bin/nobin/_preview_file.sh "$file"
  elif [[ ${input:0:2} = "M " ]]; then
    # Staged
    eval git diff --cached --color=always -- "$file"
  elif [[ ${input:0:2} = " D" || ${input:0:2} = "D " ]]; then
    eval git diff --color=always HEAD -- "$file"
  else
    eval git diff --color=always -- "$file"
  fi
done
