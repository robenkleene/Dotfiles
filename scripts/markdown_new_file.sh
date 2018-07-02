#!/usr/bin/env bash

set -e

if [ "$#" -ne 2 ]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

# Make all lowercase and replace hyphens with spaces
title=$1
directory=$2

if [[ ! -d "$directory" ]]; then
  echo "$directory is not a directory" >&2
  exit 1
fi

file_path=$(mktemp "$directory/$title-XXXX")

content="# $title
"

echo "$content" > "$file_path"
cat >> "$file_path"

destination_file_path="$directory/$title.md"
mv -n "$file_path" "$destination_file_path"
if [[ -f "$file_path" ]]; then
  # The move failed
  echo -n $file_path
else
  # The move succeeded
  echo -n $destination_file_path
fi
