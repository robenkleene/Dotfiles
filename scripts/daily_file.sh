#!/usr/bin/env bash

set -euo pipefail

dir=~/Text/journal/daily
date=$(date +%F)
filename=$date.md
filepath=$dir/$filename

if [[ ! -d "$dir" ]]; then
  echo "Error: $dir doesn't exit" >&2
  exit 1
fi

if [[ ! -f "$filepath" ]]; then
  echo -e "# $date\n\n" >> "$filepath"
fi
echo "$filepath"
