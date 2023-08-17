#!/usr/bin/env bash

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --follow"
: | fzf --ansi --reverse --disabled --keep-right --multi --query "$INITIAL_QUERY" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} $@ || true" \
    --delimiter : \
    --preview 'bat --style=plain --color=always {1} --line-range {2}: --highlight-line {2}' \
    --bind="ctrl-x:execute-silent(~/.bin/print_args {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-page-up,ctrl-d:preview-page-down" \
    --height=20 --preview-window=right,50%:wrap

