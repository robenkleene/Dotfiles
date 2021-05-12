#!/usr/bin/env bash

set -eo pipefail

if [ -n "$TMUX" ]; then
  echo "Error: Don't run inside tmux" >&2
  exit 1
fi

tmux_session_auto_save_quit && tmux_session_auto_restore_ssh
