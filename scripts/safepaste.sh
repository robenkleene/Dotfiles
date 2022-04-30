#!/bin/bash

set -e

if [ -n "$TMUX" ]; then
  tmux saveb -
elif [[ "$(uname)" == "Darwin" ]]; then
  pbpaste
else
  echo ''
fi
