#!/usr/bin/env bash

set -euo pipefail

hg status 2>/dev/null | \
  fzf --no-sort --ansi --multi \
  --preview="echo {} | ~/.bin/nobin/_fzf_preview_hg_diff.sh" \
  --bind="ctrl-e:become($EDITOR {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap \
  | sed 's/^[A-Z?] //'
