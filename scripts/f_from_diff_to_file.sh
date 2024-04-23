#!/usr/bin/env bash

set -euo pipefail

if [ $# -gt 0 ]; then
  input=$(</dev/stdin)
  for line in "$@"; do
    echo "$input" | ~/.bin/f_from_diff_to_grep "$line" | cut -d ':' -f 1 
  done
else
  ~/.bin/f_from_diff_to_grep | cut -d ':' -f 1 
fi
