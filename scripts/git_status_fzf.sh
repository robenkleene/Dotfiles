#!/usr/bin/env bash

set -euo pipefail

git status --short | \
  fzf --no-sort --ansi --multi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_git_diff.sh" \
  --bind='ctrl-v:become(vim {+}),ctrl-x:execute-silent(echo {+} | pbcopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=20 --preview-window=right,50%:wrap \
  | sed 's/^[ ?][A-Z?] //'
