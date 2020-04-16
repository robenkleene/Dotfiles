#!/usr/bin/env bash

set -e

dir="$1"
if [[ -n "$dir" ]]; then
  if [[ ! -d "$dir" ]]; then
    echo "$dir is not a valid directory" >&2
    exit 1
  fi
  cd "$dir"
fi

~/.bin/terminal_new
