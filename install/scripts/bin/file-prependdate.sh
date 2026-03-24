#!/usr/bin/env bash

set -euo pipefail

today=$(date +%F)
filename="$1"
if [[ -z "${1-}" ]]; then
  echo "Error: No file" >&2
  exit 1
fi
if [[ ! -e "$filename" ]]; then
  echo "Error: $filename doesn't exist" >&2
  exit 1
fi
newfilename="$today-$filename"
if [[ -e "$newfilename" ]]; then
  echo "Error: A file already exists at $newfilename" >&2
  exit 1
fi
mv "$filename" "$newfilename"
