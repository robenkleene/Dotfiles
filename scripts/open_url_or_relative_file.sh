#!/usr/bin/env bash

set -e

dir="$1"
command="$2"
if [[ -z "$dir" ]]; then
  echo "Error no directory" >&2
  exit 1
fi
while read -r line; do
  test_file="${dir%/}/$line"
  if [[ -f "$test_file" ]]; then
    if [[ -z "$command" ]]; then
      open "$test_file"
    else
      echo "$command"
      eval "$command \"$test_file\""
    fi
    exit 0
  fi
  echo "$line" | ~/.bin/urls_open
done
