#!/usr/bin/env bash

set -euo pipefail

eval "$EMACS_COMMAND -eval \"(yank-to-diff-buffer)\""
