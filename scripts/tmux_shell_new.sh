#!/usr/bin/env bash

set -e

if ! tmux info &> /dev/null; then
  echo "tmux is not running, start tmux first"
  exit 1
fi

# if we're already in a shell session, switch back to the previous session
if [[ -n "$TMUX" ]]; then
  if tmux display-message -p '#S' | grep -q "^\d\+$"; then
    tmux switch-client -l
    exit 0
  fi
fi

unattached_shell=$(tmux list-sessions -F "#{session_name} #{session_attached}" \
  | grep "^\d\+ 0$" | head -1 | tr -d '\n')
if [[ -z "$unattached_shell" ]]; then
  if [[ -n "$TMUX" ]]; then
    session=$(tmux new-session -d -P | tr -d '\n')
    tmux switch-client -t "$session"
  else
    tmux new-session
  fi
else
  unattached_shell=${unattached_shell::${#unattached_shell}-2}
  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$unattached_shell"
  else
    tmux attach-session -t "$unattached_shell"
  fi
fi
