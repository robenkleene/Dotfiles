#!/usr/bin/env bash

set -e

if [[ ! -t 0 ]]; then
  # Don't show any decorations when piping *to* `rg`
  exec rg "$@"
elif [[ -t 1 ]]; then
  if [[ "$TERM" = "dumb" ]]; then
    # Emacs
    exec rg --no-heading --with-filename --line-number "$@"
  else
    # Default
    exec rg --no-heading --with-filename --line-number "$@"
  fi
else
  # Use grep format and no colors when piping *from* rg
  exec rg --no-heading --with-filename --line-number "$@"
fi
