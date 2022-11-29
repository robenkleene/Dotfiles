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
    new=$(perl -pe 'chomp if eof' | sed s'/⏎$//')
    { pbpaste; echo "$new"; } | pbcopy
  else
    exec perl -pe 'chomp if eof' | sed s'/⏎$//' | pbcopy
  fi
else
  if [ -n "${TMUX:-}" ]; then
    if [[ "$append" == "true" ]]; then
      new=$(perl -pe 'chomp if eof' | sed s'/⏎$//')
      { TERM=xterm-256color tmux saveb -; echo "$new"; } | tmux loadb -
    else
      exec perl -pe 'chomp if eof' | sed s'/⏎$//' | tmux loadb -
    fi
  fi
fi

