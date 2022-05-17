#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${1:-}" ]]; then
  tac ~/.clipboard_history | rg --text "$1"
else
  tac ~/.clipboard_history
fi
