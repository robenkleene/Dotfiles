#!/usr/bin/env bash

set -euo pipefail

# We do this even if `"$TERM_PROGRAM" = "Apple_Terminal"` because otherwise
# `nvim` will try to query the terminal for this and that will display
# characters sequences on startup
export COLORTERM="truecolor"
if [ -e ~/.brew/bin/nvim ]; then
  exec ~/.brew/bin/nvim "$@"
elif  [ -e /usr/bin/nvim ]; then
  exec /usr/bin/nvim "$@"
fi
