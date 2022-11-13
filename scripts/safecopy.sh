#!/usr/bin/env bash

set -eo pipefail

# macOS has to go first to be able to copy from tmux to macOS
# It seems like Alacritty has it's own clipboard integration that conflicts
# with this, so just disable everything if Alacritty
if [[ -n $1 ]]; then
  # Unset Alacritty if we're being piped to from the `y` command
  unset ALACRITTY
fi
# Chomp the last new line break which makes it safer to paste a single line
# into the terminal.
if [[ "$(uname)" == "Darwin" && -z $ALACRITTY ]]; then
  exec perl -pe 'chomp if eof' | sed s'/⏎$//' | pbcopy
elif [ -n "${TMUX:-}" ]; then
  exec perl -pe 'chomp if eof' | sed s'/⏎$//' | tmux loadb -
else
  exec cat >/dev/null
fi
