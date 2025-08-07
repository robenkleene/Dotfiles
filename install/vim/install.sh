#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

if [ ! -e /usr/local/bin/gvim ] && [ -e /Applications/MacVim.app/Contents/bin/gvim ]; then
  sudo ln -s /Applications/MacVim.app/Contents/bin/gvim /usr/local/bin/gvim
fi
