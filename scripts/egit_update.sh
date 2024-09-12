#!/usr/bin/env bash

set -euo pipefail

settings_only="false"
while getopts ":sh" option; do
  case "$option" in
    s)
      settings_only="true"
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
if [[ "$settings_only" != "true" ]]; then
  ~/.bin/git_pull_all -t
  if [[ -e "~/.bin-local/local_pull" ]]; then
    ~/.bin-local/local_pull
  fi
fi
~/Developer/Dotfiles/install/update.sh
if [[ -e "~/.bin-local/local_update" ]]; then
  ~/.bin-local/local_update
fi
