#!/usr/bin/env bash

set -euo pipefail

# We do this even if `"$TERM_PROGRAM" = "Apple_Terminal"` because otherwise
# `nvim` will try to query the terminal for this and that will display
# characters sequences on startup
COLORTERM="truecolor" ~/.brew/bin/nvim "$@"
