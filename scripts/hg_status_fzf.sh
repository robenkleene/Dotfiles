#!/usr/bin/env bash

set -euo pipefail

hg status 2>/dev/null | awk '{$1=$1};1' | \
  fzf --no-sort --ansi --reverse --multi \
  --preview="echo {} | ~/.bin/nobin/_fzf_preview_hg_diff.sh" \
  --bind="ctrl-e:become($EDITOR {+2..}),ctrl-x:execute-silent(echo {+2..} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
