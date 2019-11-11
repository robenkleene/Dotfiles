#!/bin/bash

set -e

if [[ "$(uname)" == "Darwin" ]]; then
  pbpaste
elif [ -n "$TMUX" ]; then
  tmux saveb -
else
  echo ''
fi
