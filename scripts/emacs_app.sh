#!/usr/bin/env bash

set -e

if [[ $# -eq 0 ]]; then
  open -a "Emacs.app" .
else
  open -a "Emacs.app" "$@"
fi
