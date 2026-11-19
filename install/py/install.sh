#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

if ! command -v uv >/dev/null; then
  echo "Error: uv isn't installed" >&2
  exit 1
fi

./packages/install.sh -f "$@"
