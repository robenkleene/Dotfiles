#!/bin/bash

set -euo pipefail

if command -v pbpaste &> /dev/null; then
  pbpaste
elif [ -n "${TMUX:-}" ] && [ -z "${INSIDE_EMACS:-}" ]; then
  TERM=xterm-256color tmux saveb -
else
  cat /tmp/robenkleene.transient/clipboard 2>/dev/null || echo ''
fi
