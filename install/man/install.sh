#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# Delete all existing
destination_dir="$HOME/.man/man9"
if [[ -d "$destination_dir" ]]; then
  find -L "$destination_dir" -name "*.9" -type f -exec rm {} +
fi

while IFS= read -r; do
  ~/.bin/md_man_update "$REPLY"
done < <( find markdown -type f -name "*.md" )
