#!/usr/bin/env bash

set -euo pipefail

if command -v tmux &>/dev/null && tmux has-session 2>/dev/null; then
  exec tmux loadb -
fi
