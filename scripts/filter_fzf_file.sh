#!/usr/bin/env bash

set -euo pipefail

fzf --ansi --multi --preview "$HOME/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  ${FZF_DEFAULT_PREVIEW_OPTS:-}
