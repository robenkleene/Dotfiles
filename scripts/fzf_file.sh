#!/usr/bin/env bash

set -euo pipefail

exec fzf --ansi --keep-right --multi --preview "bat --style=plain --color=always {}" \
  --bind="alt-e:execute(${EDITOR:-vim} {+}),alt-a:select-all,alt-d:deselect-all"
