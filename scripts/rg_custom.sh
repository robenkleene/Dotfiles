#!/usr/bin/env bash

set -e

# Only use colors in an interactive shell
if [ -t 1 ]; then
  if [ "$TERM" = "dumb" ]; then
    exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$@"
  else
    exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$@" #| less -RFX
  fi
else
    exec rg --with-filename --smart-case --line-number "$@"
fi
