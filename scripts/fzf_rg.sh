#!/usr/bin/env bash

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
: | fzf --ansi --reverse --disabled --keep-right --multi --query "$INITIAL_QUERY" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} $@ || true" \
    --delimiter : \
    --preview 'bat --style=plain --color=always {1} --line-range {2}: --highlight-line {2}' \
    --bind="ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
    --height=20 --preview-window=right,50%:wrap
