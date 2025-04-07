#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# Use GUI Emacs CLI instead of managing a separate `brew install`
if [ ! -e /usr/local/bin/emacs ] && [ -e /Applications/Emacs.app/Contents/MacOS/emacs-nw ]; then
  sudo ln -s /Applications/Emacs.app/Contents/MacOS/emacs-nw /usr/local/bin/emacs
fi

exec emacs --script packages.el
