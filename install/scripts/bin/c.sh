#!/usr/bin/env bash

set -euo pipefail

if [[ $# -gt 0 ]]; then
  # `$(...)` strips `rk-path-abs`'s trailing newline so it isn't copied
  printf '%s' "$(~/.bin/rk-path-abs "$@")" | ~/.bin/nobin/_rk-tmux-safecopy.sh
else
  exec ~/.bin/nobin/_rk-tmux-safecopy.sh
fi
