#!/usr/bin/env bash

set -e

if [[ -n "$1" ]]; then
  if [[ ! -d "$1" ]]; then
    echo "Usage: git-sync-remotes <root directory>"
    exit 1
  else
    cd "$1"
  fi
fi

find . -type d -execdir test -d "{}/.git" \; -print -prune | while read dir; do
  url=$(cd "$dir" && git ls-remote --get-url)
  echo "$url \"$dir\""
done
