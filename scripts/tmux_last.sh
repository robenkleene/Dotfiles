#!/usr/bin/env bash

set -e

if ! tmux info &> /dev/null; then
  echo "tmux is not running, start tmux first"
  exit 1
fi

# Go to last window or last session if that fails
if ! tmux last-window &> /dev/null; then
  tmux switch-client -l
fi
