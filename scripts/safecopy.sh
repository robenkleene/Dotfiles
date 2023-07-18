#!/usr/bin/env bash

set -eo pipefail

append="false"
force="false"
while getopts ":fah" option; do
  case "$option" in
    a)
      append="true"
      ;;
    f)
      force="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done

# macOS has to go first to be able to copy from tmux to macOS
# It seems like Alacritty has it's own clipboard integration that conflicts
# with this, so just disable everything if Alacritty
# if [[ "$force" == "true" ]]; then
#   # Unset Alacritty if we're being piped to from the `y` command
#   unset ALACRITTY
# fi
# Chomp the last new line break which makes it safer to paste a single line
# into the terminal.
if [[ "$(uname)" == "Darwin" ]]; then
# if [[ "$(uname)" == "Darwin" && -z $ALACRITTY ]]; then
  if [[ "$append" == "true" ]]; then
    # Don't do anything fancy with trimming new lines, otherwise that makes it
    # hard to append multiple selections that contain trailing new lines
    { pbpaste; sed s'/⏎$//'; } | pbcopy
  else
    sed s'/⏎$//' | pbcopy
    if [ -n "${TMUX:-}" ] && [ -z "${INSIDE_EMACS:-}" ]; then
      # Always also copy to the tmux clipboard so that pasting inside tmux with
      # `paste-buffer` works
      pbpaste | tmux loadb -
    fi
  fi
elif [ -n "${TMUX:-}" ] && [ -z "${INSIDE_EMACS:-}" ]; then
  # Never use `TMUX` `INSIDE_EMACS` because the `TMUX` session may no longer be running
  # Don't do anything fancy with trimming new lines, otherwise that makes it
  # hard to append multiple selections that contain trailing new lines
  if [[ "$append" == "true" ]]; then
    { TERM=xterm-256color tmux saveb -; sed s'/⏎$//'; } | tmux loadb -
  else
    sed s'/⏎$//' | tmux loadb -
  fi
else
  sed s'/⏎$//' > /tmp/robenkleene.transient/clipboard
fi
