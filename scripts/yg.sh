#!/usr/bin/env bash

set -euo pipefail

eval "$EMACS_COMMAND -eval \"(rk/yank-to-grep-buffer-startup)\""
