#!/usr/bin/env bash

set -e

directory="$1"
if [[ -z "$directory" ]]; then
  directory="$PWD"
fi
title="$2"

if [[ -z "$title" ]]; then
  text=$(cat)
  while read -r line; do
    if [[ -n "$title" && -n "$line" ]]; then
      echo "Only use line at a time" >&2
      exit 1
    fi
    title="$line"
  done <<< "$text"
fi

if [[ -z "$title" ]]; then
  echo "No valid title found" >&2
  exit 1
fi

slug=$(echo "$title" | ~/.bin/slug)
file_path=$(~/.bin/markdown_new_file "$title" "$directory" "$slug")
relative_file_path=$(perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . "\n"' "$file_path" "$directory")
echo -n "[$title]($relative_file_path)"
