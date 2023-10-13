#!/bin/bash

set -euo pipefail

if [[ -n "${TMUX:-}" ]] && [[ -z "${INSIDE_EMACS:-}" ]]; then
  TERM=xterm-256color tmux saveb -
elif command -v pbpaste &> /dev/null; then
  pbpaste
else
  cat /tmp/robenkleene.transient/clipboard 2>/dev/null || echo ''
fi
