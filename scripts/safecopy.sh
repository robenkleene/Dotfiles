#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
  sed s'/⏎$//' | pbcopy "$@"
elif [ -n "$TMUX" ]; then
  sed s'/⏎$//' | tmux loadb -
  # sed s'/⏎$//' | tee >(~./bin/clipboard_history_save) | tmux loadb -
else
  cat >/dev/null
fi
