#!/usr/bin/env bash

set -euo pipefail

if [[ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]]; then
  exec "/Applications/Emacs.app/Contents/MacOS/Emacs" "-nw" "$@"
else [[ -f "$HOME/.brew/bin/emacs" ]]; then
  exec "$HOME/.brew/bin/emacs" "-nw" "$@"
else
  exec emacs "-nw" "$@"
fi
