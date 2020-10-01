#!/usr/bin/env zsh

set -e

setopt localoptions pipefail 2> /dev/null
# find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' \
fd ".*\.(xcodeproj|xcworkspace)$" --type d --exclude "project.xcworkspace" \
  | grep -vE "\/Carthage\/" \
  | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 $FZF_DEFAULT_OPTS" fzf +m \
  | tr '\n' '\0' \
  | xargs -0 env -i open
