#!/usr/bin/env bash

set -euo pipefail

fzf -d ':' -n 2.. --ansi --reverse --multi \
  --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind="ctrl-x:execute-silent(~/.bin/print_args {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
