#!/usr/bin/env bash

set -euo pipefail

param=""
if [[ -n "${1:-}" ]]; then
  param=" -d $1"
fi

exec ~/.bin/ls_fzf -r${param}
