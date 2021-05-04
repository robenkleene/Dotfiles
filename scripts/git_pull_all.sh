#!/usr/bin/env bash

set -eo

text_only="false"
while getopts ":th" option; do
  case "$option" in
    t)
      text_only="true"
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

if [[ "$text_only" == "false" ]]; then
  ~/.bin/egit -u
fi
cd "$HOME/Developer/Dotfiles/scripts" && ./install.sh

~/.bin/check_repos

~/.bin/sgitt -u
if [[ "$text_only" == "true" ]]; then
  exit 0
fi

~/.bin/sgitp -u
if [[ "$(uname)" = "Darwin" ]]; then
  ~/.bin/sgitm -u
fi
