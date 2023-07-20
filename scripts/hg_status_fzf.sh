#!/usr/bin/env bash

set -euo pipefail

hg status 2>/dev/null | \
  fzf --no-sort --ansi --multi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_hg_diff.sh" \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=40% \
  --preview-window '<30(bottom,30%):wrap' | sed 's/^[A-Z?] //'
