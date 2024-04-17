#!/usr/bin/env bash

set -euo pipefail

exec fzf -d ':' -n 2.. --ansi --reverse --keep-right --multi \
  --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind="ctrl-e:execute(${EDITOR:-vim} +{2} {1}),ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
