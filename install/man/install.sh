#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# Delete all existing
find -L "$destination_dir" -name "*.9" -type f -exec rm {} +

while IFS= read -r; do
  ~/.bin/md_man_update "$REPLY"
done < <( find markdown -type f -name "*.md" )
