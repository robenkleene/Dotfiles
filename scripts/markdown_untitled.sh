#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

directory="$1"
if [[ ! -d "$directory" ]]; then
  echo "$directory is not a directory" >&2
  exit 1
fi
date=$(date +%Y-%m-%d-%s)
source=$(mktemp "${directory}/${date}-XXXX")
destination="${directory}/${date}.md"

mv -n "$source" "$destination"
if [[ -f "$source" ]]; then
  echo -n "$source"
else
  echo -n "$destination"
fi
