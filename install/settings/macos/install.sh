#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

./defaults.sh

if [[ ! -e "$HOME/Library/KeyBindings"  ]]; then
  mkdir -p "$HOME/Library/KeyBindings"
  if [[ -e "$HOME/Library/KeyBindings/DefaultKeyBinding.dict" ]]; then
    cp DefaultKeyBinding.dict "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
  fi
fi
