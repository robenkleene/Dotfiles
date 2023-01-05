#!/usr/bin/env bash

set -euo pipefail

eval "$EMACS_COMMAND -nw -eval \"(rk/grep-from-clipboard)\""
