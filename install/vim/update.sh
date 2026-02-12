#!/usr/bin/env bash

set -euo pipefail

# Delete old view files that haven't been modified in over a year
# view stores transient information about buffers like fold state
if [ -e ~/.vim/view/ ]; then
  find ~/.vim/view/ -maxdepth 1 -type f \( -name '~=*=' -o -name '=*=' \) -mtime +365 -exec rm {} +
fi
