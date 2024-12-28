#!/usr/bin/env bash

set -euo pipefail

if [ $# -gt 0 ]; then
  input=$(</dev/stdin)
  for line in "$@"; do
    echo "$input" | ~/.bin/t_diff_grep "$line" | cut -d ':' -f 1
  done
else
  ~/.bin/t_diff_grep | cut -d ':' -f 1
fi
