#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

if [[ "$(uname)" = "Darwin" ]]; then
  cd macos
  brew bundle -f
elif [[ "$(uname)" = "Linux" ]]; then
  cd linux
  brew bundle -f
else
  echo "Error: Unsupported platform" >&2
  exit 1
fi
