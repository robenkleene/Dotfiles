#!/usr/bin/env bash

set -euo pipefail

if [[ ! "$1" =~ [a-z] ]]; then
  echo "Error: $1 is not a register" >&2
fi

if [[ "${2-}" = "-" ]]; then
  tmux load-buffer -b "$1" -
else
  tmux show-buffer -b "$1"
fi
