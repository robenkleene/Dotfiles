#!/usr/bin/env bash

set -euo pipefail

if [ $# -gt 0 ]; then
  input=$(</dev/stdin)
  for line in "$@"; do
    echo "$input" | ~/.bin/rk-t-diff-grep -H "$line" | cut -d ':' -f 1
  done
else
  ~/.bin/rk-t-diff-grep -H | cut -d ':' -f 1
fi
