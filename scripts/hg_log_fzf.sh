#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hg log --template '{node|short} {author|user}: {desc|strip|firstline}\n' --limit 100 "$1" | \
  fzf --no-sort --ansi \
  --bind="ctrl-e:become($EDITOR {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap \
  | grep --only-matching "[a-f0-9]\{7\}" | sed 's/\s.*$//'
