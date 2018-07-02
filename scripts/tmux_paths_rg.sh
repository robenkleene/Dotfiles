#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No search term specified"
  exit 1
fi

tmux-paths -0 | xargs -0 rg --smart-case --line-number "$@"
