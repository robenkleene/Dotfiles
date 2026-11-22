#!/usr/bin/env bash

set -euo pipefail

if [[ $# -gt 0 ]]; then
  # `$(...)` strips `rk-path-abs`'s trailing newline so it isn't copied
  path=$(~/.bin/rk-path-abs "$@")
  printf '%s' "$path" | ~/.bin/nobin/_rk-tmux-safecopy.sh
  # Print the copied path as feedback
  printf '%s\n' "$path"
else
  exec ~/.bin/nobin/_rk-tmux-safecopy.sh
fi
