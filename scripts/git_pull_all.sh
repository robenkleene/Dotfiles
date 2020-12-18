#!/usr/bin/env bash

set -e

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

cd "$HOME/Developer/Settings/Source Control/Directories/Text" &&
  ./compare.sh
if [[ "$(uname)" = "Darwin" ]]; then
  cd "$HOME/Developer/Settings/Source Control/Directories/Projects" &&
    ./compare.sh mac.txt
  cd "$HOME/Developer/Settings/Source Control/Directories/Max/" &&
    ./compare.sh
elif [[ "$(uname)" = "Linux" ]]; then
  cd "$HOME/Developer/Settings/Source Control/Directories/Projects" &&
    ./compare.sh linux.txt
fi

~/.bin/sgitt -u
if [[ "$text_only" == "true" ]]; then
  exit 0
fi
~/.bin/sgitp -u
if [[ "$(uname)" = "Darwin" ]]; then
  ~/.bin/sgitm -u
fi
