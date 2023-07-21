#!/usr/bin/env bash

set -euo pipefail

fzf -d ':' -n 2.. --ansi --multi \
  --preview 'bat --style=plain --style=numbers --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=40% \
  --preview-window '<30(bottom,30%):wrap' 
