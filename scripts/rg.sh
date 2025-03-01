#!/usr/bin/env bash

set -euo pipefail

if [ -t 1 ]; then
  exec ~/.brew/bin/rg --json --with-filename "$@" |\
    ~/.brew/bin/delta --syntax-theme=none --relative-paths --hyperlinks --hyperlinks-file-link-format='vscode://file/{path}:{line}'
else
  exec ~/.brew/bin/rg "$@"
fi