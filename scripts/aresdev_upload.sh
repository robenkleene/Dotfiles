#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Error: Missing argument" >&2
  exit 1
fi

scp "$1" aresdev:/home/robenkleene/${2:-}
