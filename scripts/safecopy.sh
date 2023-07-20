#!/usr/bin/env bash

set -eo pipefail

append="false"
while getopts ":r:ah" option; do
  case "$option" in
    r)
      register="$OPTARG"
      ;;
    a)
      append="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

register_parameter=""
if [[ -n "${register:-}" ]]; then
  register_parameter=" -b ${register} "
fi

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
      pbpaste | tmux loadb${register_parameter} -
    fi
  fi
elif [ -n "${TMUX:-}" ] && [ -z "${INSIDE_EMACS:-}" ]; then
  # Never use `TMUX` `INSIDE_EMACS` because the `TMUX` session may no longer be running
  # Don't do anything fancy with trimming new lines, otherwise that makes it
  # hard to append multiple selections that contain trailing new lines
  if [[ "$append" == "true" ]]; then
    { TERM=xterm-256color tmux saveb${register_parameter} -; sed s'/⏎$//'; } | tmux loadb"${register_parameter}" -
  else
    sed s'/⏎$//' | tmux loadb${register_parameter} -
  fi
else
  sed s'/⏎$//' > /tmp/robenkleene.transient/clipboard
fi
