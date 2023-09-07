#!/usr/bin/env bash

set -euo pipefail

if [[ ! -t 0 ]]; then
  fzf -d ':' -n 2.. --ansi --reverse --keep-right --multi \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-v:become(echo {+} | vim -c GrepBuffer -),ctrl-x:execute-silent(~/.bin/print_args {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
    --height=20 --preview-window=right,50%:wrap
else
  exec rg --no-heading --with-filename --line-number --color=always "$@" | fzf -d ':' -n 2.. --ansi --reverse --keep-right --multi \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-v:become(echo {+} | vim -c GrepBuffer -),ctrl-x:execute-silent(~/.bin/print_args {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
    --height=20 --preview-window=right,50%:wrap
fi
