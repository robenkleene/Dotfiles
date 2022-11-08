#!/usr/bin/env bash

set -e

# Only use colors in an interactive shell
if [[ -t 1 ]]; then
  if [[ "$TERM" = "dumb" ]]; then
    exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$@"
  else
    # With pager
    # exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$@" | less -RFX
    # Without pager works nicer if a search is taking a long time and we need to cancel
    exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$@"
  fi
else
  # Don't show any decorations when piping to `rg`
  exec rg --smart-case "$@"
fi
