#!/usr/bin/env bash

set -euo pipefail

fzf --ansi --reverse --keep-right --multi --preview "bat {}" \
  --bind="ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,ctrl-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
