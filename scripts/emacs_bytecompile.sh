#!/usr/bin/env bash

set -euo pipefail

emacs --batch -nw -eval '(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)' 2> /dev/null
