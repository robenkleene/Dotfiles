#!/usr/bin/env bash

set -e
title="$1"
if [[ -z "$title" ]]; then
  echo "No title" >&2
  exit 1
fi
filename=$(~/.bin/jekyll_new_draft -t "$title")
eval "$EDITOR $filename"
