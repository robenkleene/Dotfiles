#!/usr/bin/env bash

set -euo pipefail

file=$(cat | sed 's/^[ ?][A-Z?] //' | head -1)

if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
  git diff --color=always "$file"
else
  ~/.bin/nobin/_fzf_preview_file.sh "$file"
fi
