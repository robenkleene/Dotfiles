#!/usr/bin/env bash

set -uo pipefail

result=$(tmux list-sessions -F "#S" | fzf-tmux)
if [[ -z "$result" ]]; then
  exit 0
fi
echo "$result" | tr "\n" "\0" | xargs -0 tmux switch-client -t
