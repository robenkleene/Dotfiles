#!/usr/bin/env bash

RG_PREFIX="fd "
INITIAL_QUERY="${*:-}"
: | fzf --ansi --reverse --disabled --multi --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --delimiter : \
    --preview "$HOME/.bin/nobin/_fzf_preview_file.sh {}" \
    --bind="ctrl-e:become($EDITOR {+}),alt-p:become(~/.bin/nobin/_fzf_preview_file.sh {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
    --height=20 --preview-window=right,50%:wrap
