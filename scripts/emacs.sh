#!/usr/bin/env bash

set -euo pipefail

if [[ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]]; then
  exec "/Applications/Emacs.app/Contents/MacOS/Emacs" "-nw" "$@"
elif [[ -f "$HOME/.brew/bin/emacs" ]]; then
  exec "$HOME/.brew/bin/emacs" "-nw" "$@"
elif [[ -f "/usr/bin/emacs" ]]; then
  exec "/usr/bin/emacs" "-nw" "$@"
fi
