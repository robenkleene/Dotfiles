#!/usr/bin/env bash

set -e

if [[ ! -t 0 ]]; then
  # Don't show any decorations when piping to `rg`
  exec rg --smart-case "$@"
elif [[ -t 1 ]]; then
  if [[ "$TERM" = "dumb" ]]; then
    exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' "$@"
  else
    # With pager
    # exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' "$@" | less -RFX
    # Without pager works nicer if a search is taking a long time and we need to cancel
    exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' "$@"
  fi
else
  # Remove colors when piping from rg
  exec rg --no-heading --with-filename --smart-case --line-number "$@"
fi
