#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  sed s'/⏎$//' | pbcopy "$@"
elif [ -n "$TMUX" ]; then
  sed s'/⏎$//' | tmux loadb -
else
  cat >/dev/null
fi
