#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
  echo "Wrong number of arguments" >&2
  exit 1
fi

title="$1"
slug=$(~/.bin/slug "$1")
mkdir -p "$slug"
temp_path=$(mktemp "$slug/README-XXXX")

echo "# $title" >"$temp_path"

destination_path="$slug/README.md"
mv -n "$temp_path" "$destination_path"
if [[ -f "$temp_path" ]]; then
  echo -n "$temp_path"
else
  echo -n "$destination_path"
fi
