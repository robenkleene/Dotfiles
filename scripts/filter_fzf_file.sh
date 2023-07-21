#!/usr/bin/env bash

set -euo pipefail

fzf --ansi --multi --preview "$HOME/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind='ctrl-v:become(vim {+}),ctrl-x:execute-silent(echo {+} | pbcopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=20 --preview-window=right,50%:wrap
  
