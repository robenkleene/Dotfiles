#!/usr/bin/env bash

set -euo pipefail

settings_only="false"
all="false"
while getopts ":sah" option; do
  case "$option" in
    s)
      settings_only="true"
      ;;
    a)
      all="true"
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

~/.bin/egit -u
if [[ "$all" == "true" ]]; then
  ~/.bin/git-pull-all
elif [[ "$settings_only" != "true" ]]; then
  ~/.bin/git-pull-all -t
fi
~/Developer/Dotfiles/install/update.sh
