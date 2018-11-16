#!/usr/bin/env bash

set -e

if [ "$#" -lt 1 ]; then
  echo "Wrong number of arguments" >&2
  exit 1
fi

if [[ -n "$2" ]]; then
  cd "$2"
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
