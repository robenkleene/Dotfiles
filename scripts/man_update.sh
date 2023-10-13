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

while IFS= read -r; do
  source="$REPLY"
  filename=$(basename -- "$source")
  filename="${filename%.*}"
  title=$(echo "$filename" | awk '{print toupper($0)}')
  # Instead just use `man 9 <command>` to access this version
  # if [[ ! "$filename" =~ '-' ]]; then
  #   filename="${filename}-overview"
  # fi
  dest="$destination_dir/$filename".9
  if [[ -e "$dest" ]]; then
    echo "Warning: Skipping $dest because it already exists, using $source" >&2
  fi
  pandoc --standalone --to man --from markdown <({ echo "% ${title}(9) Reference"; cat "$source"; }) --output "$dest"
done < <( find ~/Documentation -type f -name "*.md" -exec awk '/^%/{print FILENAME} {nextfile}' {} + )
