#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$1" ]]; then
  echo "Error: Missing path" >&2
fi

sftp aresdev:"\"$1\"" .
