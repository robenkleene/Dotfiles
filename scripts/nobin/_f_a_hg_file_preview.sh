#!/usr/bin/env bash

set -euo pipefail

input=$(cat)
file=${input#*[A-Z?] }
if [[ ${input:0:1} != "?" ]]; then
  hg diff --color=always "$file"
else
  ~/.bin/nobin/_preview_file.sh "$file"
fi
