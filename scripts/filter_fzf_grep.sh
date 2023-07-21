#!/usr/bin/env bash

set -euo pipefail

fzf -d ':' -n 2.. --ansi --multi \
  --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  ${FZF_DEFAULT_PREVIEW_OPTS:-} 
