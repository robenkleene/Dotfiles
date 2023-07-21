#!/usr/bin/env bash

RG_PREFIX="fd "
INITIAL_QUERY="${*:-}"
: | fzf --ansi --disabled --multi --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --delimiter : \
    --preview '~/.bin/nobin/_fzf_preview_file.sh {}' \
    --preview-window '<30(bottom,30%):wrap'
