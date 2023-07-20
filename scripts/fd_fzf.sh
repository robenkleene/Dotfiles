#!/usr/bin/env bash

set -euo pipefail

if [[ -n "$1" ]]; then
  cd "$1"
fi

exec ~/.bin/ls_fzf -r
