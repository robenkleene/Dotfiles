#!/bin/bash

set -e

if [[ "$(uname)" == "Darwin" ]]; then
  pbpaste
elif [ -n "$TMUX" ]; then
  TERM=xterm-256color tmux saveb -
else
  cat /tmp/robenkleene.transient/clipboard 2>/dev/null || echo ''
fi
