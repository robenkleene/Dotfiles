#!/usr/bin/env bash

set -euo pipefail

for arg in "$@"; do
  if [[ -f "$arg" ]]; then
    git -C "$(dirname $arg)" rev-parse --show-toplevel
  elif [[ -d "$arg" ]]; then
    git -C "$arg" rev-parse --show-toplevel
  else
    echo "Error: $arg is not a file or directory" >&2
    exit 1
  fi
done
