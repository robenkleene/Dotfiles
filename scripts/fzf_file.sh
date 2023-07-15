#!/usr/bin/env bash

set -euo pipefail

fzf --ansi --no-sort --multi --preview "$HOME/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=100% \
  --preview-window '<30(bottom,30%):wrap' 
