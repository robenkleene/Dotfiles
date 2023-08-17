#!/usr/bin/env bash

RG_PREFIX="fd --color=always --follow"
: | fzf --ansi --reverse --disabled --keep-right --multi --query "$INITIAL_QUERY" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} $@ || true" \
    --delimiter : \
    --preview "$HOME/.bin/nobin/_fzf_preview_file.sh {}" \
    --bind="ctrl-e:become($EDITOR {+}),alt-p:become(~/.bin/nobin/_fzf_preview_file.sh {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-page-up,ctrl-d:preview-page-down" \
    --height=20 --preview-window=right,50%:wrap
