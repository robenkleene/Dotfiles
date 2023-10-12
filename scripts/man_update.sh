#!/usr/bin/env bash

set -euo pipefail

destination_dir="$HOME/.man/man9"
if [ ! -e "$destination_dir" ]; then
  mkdir -p "$destination_dir"
elif [ ! -d "$destination_dir" ]; then
  echo "Destination $destination_dir exist and it's not a directory" >&2
  exit 1
fi

# Delete all existing
find -L "$destination_dir" -name "*.9" -type f -exec rm {} +

while IFS= read -r -d '' -u 9; do
  filename=$(basename -- "$REPLY")
  filename="${filename%.*}"
  if [[ ! "$filename" =~ '-' ]]; then
    filename="${filename}-overview"
  fi
  dest="$destination_dir/$filename".9
  if [[ -e "$dest" ]]; then
    echo "Warning: Skipping $dest because it already exists" >&2
  fi
  pandoc --standalone -t man "$REPLY" --output "$dest"
done 9< <( find ~/Documentation -name "*.md" -type f -exec printf '%s\0' {} + )

