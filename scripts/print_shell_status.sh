#!/usr/bin/env bash

set -e

# Startup

if command -v tmux &> /dev/null; then
  if tmux ls >/dev/null 2>/dev/null; then
    if [ -n "$TMUX" ]; then
      exit 0
    fi
    if [ "$TERM_PROGRAM" = "vscode" ]; then
      exit 0
    fi

    if pgrep -f '[Ee]macs.*--bg-daemon' >/dev/null; then
      echo "Emacs server is running"
    fi

    if pgrep mysqld >/dev/null; then
      echo "MySQL is running"
    fi

    echo tmux sessions
    tmux ls
  fi
fi
