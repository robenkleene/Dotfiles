#!/usr/bin/env bash

set -e

if [[ ! -t 0 ]]; then
  # Don't show any decorations when piping *to* `rg`
  exec rg --smart-case "$@"
elif [[ -t 1 ]]; then
  if [[ "$TERM" = "dumb" ]]; then
    # Emacs
    exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' "$@"
  else
    # Default
    exec rg --smart-case --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' "$@"
  fi
else
  # Use grep format and no colors when piping *from* rg
  exec rg --no-heading --with-filename --smart-case --line-number "$@"
fi
