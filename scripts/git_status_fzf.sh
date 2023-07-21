#!/usr/bin/env bash

set -euo pipefail

git status --short | \
  fzf --no-sort --ansi --multi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_git_diff.sh" \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  ${FZF_DEFAULT_PREVIEW_OPTS:-} | sed 's/^[ ?][A-Z?] //'
