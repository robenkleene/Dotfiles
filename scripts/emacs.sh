#!/usr/bin/env bash

set -euo pipefail

if [[ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]]; then
  exec "/Applications/Emacs.app/Contents/MacOS/Emacs -nw" "$@"
else
  exec "$HOME/.brew/bin/emacs -nw" "$@"
fi
