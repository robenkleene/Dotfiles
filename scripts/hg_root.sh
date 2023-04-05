#!/usr/bin/env bash

set -euo pipefail

cd "$(hg root)" || return
if [[ -n "$1" ]]; then
  exec "$@"
fi
