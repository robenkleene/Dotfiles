#!/usr/bin/env bash

set -euo pipefail

git status --short | \
  fzf --no-sort --ansi --reverse --multi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_git_diff.sh" \
  --bind="ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,alt-p:become(echo {+} | ~/.bin/nobin/_fzf_preview_git_diff.sh),ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
