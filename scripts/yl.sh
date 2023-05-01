#!/usr/bin/env bash

set -euo pipefail

eval "$EMACS_COMMAND -eval \"(rk/yank-to-virtual-dired-buffer-startup)\""
