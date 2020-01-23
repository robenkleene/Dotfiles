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
for markdown_file in "$drafts_directory"/*.md; do
  mv -n "$markdown_file" "$posts_directory"
  if [[ -f "$markdown_file" ]]; then
    echo "Moving $markdown_file failed" >&2
  fi
done
