#!/usr/bin/env bash

set -euo pipefail

fzf -d ':' -n 2.. --ansi --no-sort --multi \
  --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=100% \
  --preview-window '<30(bottom,30%):wrap' 
