#!/usr/bin/env bash

set -e

drafts_directory=~/Development/Projects/Web/robenkleene.github.io/_drafts
posts_directory=~/Development/Projects/Web/robenkleene.github.io/_posts

if [[ ! -d "$drafts_directory" ]]; then
  echo "$drafts_directory is not a directory" >&2
  exit 1
fi


if [[ ! -d "$posts_directory" ]]; then
  echo "$posts_directory is not a directory" >&2
  exit 1
fi

shopt -s nullglob
for path in "$drafts_directory"/*.md; do
  filename=$(basename "$path")
  if [[ ! $filename =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])-[^[:space:]]*\.md$ ]]; then
    echo "$filename is an invalid filename" >&2
    exit 1
  fi
  today=$(date +%Y-%m-%d)
  new_filename=${today}-${filename:11}
  if [[ ! $new_filename =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])-[^[:space:]]*\.md$ ]]; then
    echo "New $new_filename is an invalid filename" >&2
    exit 1
  fi
  destination="${posts_directory}/${new_filename}"
  mv -n "$path" "$destination"
  if [[ -f "$path" ]]; then
    echo "Moving $path failed" >&2
  fi
done
