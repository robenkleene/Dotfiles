#!/usr/bin/env bash

set -euo pipefail

if [[ ! "$(uname)" = "Darwin" ]]; then
  echo "Error: Only run this on Darwin" >&2
  exit 0
fi

cd "$(dirname "$0")" || exit 1

./defaults.sh

if [[ ! -e "$HOME/Library/KeyBindings"  ]]; then
  mkdir -p "$HOME/Library/KeyBindings"
fi

# Try without this bindings file
# if [[ ! -e "$HOME/Library/KeyBindings/DefaultKeyBinding.dict" ]]; then
#   cp DefaultKeyBinding.dict "$HOME/Library/KeyBindings/"
# fi
