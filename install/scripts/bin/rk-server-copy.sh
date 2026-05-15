#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Error: Missing host argument" >&2
  echo "Usage: $(basename "$0") <host>" >&2
  exit 1
fi

# Pipe standard input into `rk-copy` on the remote host so it lands on that
# server's clipboard
exec ssh "$1" '~/.bin/rk-copy'
