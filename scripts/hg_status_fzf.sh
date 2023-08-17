#!/usr/bin/env bash

set -euo pipefail

hg status 2>/dev/null | awk '{$1=$1};1' | \
  fzf --no-sort --ansi --reverse --multi \
  --preview="echo {} | ~/.bin/nobin/_f_a_hg_file_preview.sh" \
  --bind="ctrl-e:become($EDITOR {+2..}),ctrl-x:execute-silent(echo {+2..} | ~/.bin/safecopy)+accept,ctrl-u:preview-page-up,ctrl-d:preview-page-down" \
  --height=20 --preview-window=right,50%:wrap
