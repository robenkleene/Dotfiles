#!/usr/bin/env bash

set -euo pipefail

dir=~/Text/journal
filename=$(date +%F).md
filepath=$dir/$filename

if [[ ! -d "$dir" ]]; then
  echo "Error: $dir doesn't exit" >&2
  exit 1
fi

if [[ ! -f "$filepath" ]]; then
  touch "$filepath"
fi
echo "$filepath"
