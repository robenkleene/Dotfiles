#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$1" ]]; then
  echo "Error: Missing argument" >&2
  exit 1
fi

sftp aresdev:"\"$1\"" .
