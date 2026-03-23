#!/usr/bin/env bash

set -euo pipefail

if [ $# -gt 0 ]; then
  input=$(</dev/stdin)
  for line in "$@"; do
    echo "$input" | ~/.bin/t_diff_grep -H "$line" | cut -d ':' -f 1
  done
else
  ~/.bin/t_diff_grep -H | cut -d ':' -f 1
fi
