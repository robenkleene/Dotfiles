#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=" ."
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

git log --graph --color=always --format="%C(auto)%h %s%d"${separator}"${1}" | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview "echo {} | ~/.bin/_fzf_preview_git_commit \"$1\"" \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=100% \
  --preview-window '<30(bottom,30%):wrap' | grep --only-matching "[a-f0-9]\{7\}"
