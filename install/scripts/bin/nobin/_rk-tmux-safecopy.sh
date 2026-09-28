#!/usr/bin/env bash

set -euo pipefail

if command -v tmux &>/dev/null && tmux has-session 2>/dev/null; then
  # `-w` flag also syncs this to the system clipboard, including over SSH (with `OSC 52`)
  exec tmux loadb -w "$@" -
fi
