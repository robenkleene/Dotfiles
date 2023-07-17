#!/usr/bin/env bash

set -euo pipefail

backup_root_directory=~/Archive/Text/
archive_file=$(find "$backup_root_directory" | sort | tail -1 | tr -d '\n')
if [[ "$1" = "-f" ]]; then
  echo $archive_file
  exit 0
fi
cat >> "$archive_file"
