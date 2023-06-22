#!/usr/bin/env bash

set -euo pipefail

git log --graph --color=always --format="%C(auto)%h %s%d " | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview 'echo {} | ~/.bin/nobin/_git_fzf_commit_preview.sh' \
  --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up' \
  --height=100% \
  --preview-window=top | grep --only-matching "[a-f0-9]\{7\}"
