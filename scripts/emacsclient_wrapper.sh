#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${1-}" ]]; then
  exec emacsclient -nw "$@"
else
  emacsclient -nw .
fi
