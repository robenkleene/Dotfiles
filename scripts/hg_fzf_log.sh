#!/usr/bin/env bash

set -euo pipefail

hg log --template '{node|short} {author|user}: {desc|strip|firstline}\n' --limit 100 | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview 'echo {} | ~/.bin/nobin/_hg_fzf_rev_preview.sh' \
  --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up' \
  --height=100% \
  --preview-window '<30(bottom,30%)' | grep --only-matching "[a-f0-9]\{7\}"
