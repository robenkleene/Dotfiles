#!/usr/bin/env bash

set -euo pipefail

input=$(cat)
file=${input#*[A-Z?] }
if [[ ${input:0:1} != "?" ]]; then
  nvim "$file"
else
  git difftool "$file"
fi
