#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)" || return
if [[ -n "$1" ]]; then
  exec "$@"
fi
