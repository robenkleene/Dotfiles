#!/usr/bin/env bash

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"
: | fzf --ansi --disabled --multi --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --delimiter : \
    --preview 'bat --style=plain --color=always {1} --line-range {2}: --highlight-line {2}' \
    --preview-window '<30(bottom,30%):wrap'