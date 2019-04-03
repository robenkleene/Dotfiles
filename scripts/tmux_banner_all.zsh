#!/usr/bin/env zsh

# Setting this as `zsh` allows it to be called from AppleScript for some reason
for i in $(tmux list-sessions -F "#{?session_attached,#S,}" | grep .); do
  # tmux send -t $i tmux-banner ENTER
  tmux run-shell -t "$i" "~/.bin/tmux_banner" >/dev/null
done
