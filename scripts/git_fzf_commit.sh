#!/usr/bin/env bash

set -euo pipefail

git log --graph --color=always --format="%C(auto)%h %s%d " | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview 'command git show --color=always (echo {} | command grep -o \"[a-f0-9]\{7,\}\")' \
  --preview-window=top:15 | grep -o "[a-f0-9]\{7,\}"
