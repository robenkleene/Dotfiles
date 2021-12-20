#!/usr/bin/env bash

if [[ ! "$(uname)" = "Darwin" ]]; then
  echo "Error: Only run this on Darwin" >&2
  exit 0
fi

set -euo pipefail

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO
