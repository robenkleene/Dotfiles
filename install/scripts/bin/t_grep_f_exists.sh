#!/usr/bin/env bash

set -euo pipefail

while IFS= read -r line; do
  file_path="${line%%:*}"
  if [[ -f "$file_path" ]]; then
    echo $line
  fi
done
