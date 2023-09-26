#!/usr/bin/env bash

set -e

tmux rename-window "$(basename "$PWD")"

# Save if possible
if [[ -x ~/.tmux/plugins/tmux-resurrect/scripts/save.sh ]]; then
  ~/.tmux/plugins/tmux-resurrect/scripts/save.sh
fi
