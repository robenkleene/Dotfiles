#!/usr/bin/env bash

set -e
set -o pipefail

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
else
  if [[ ! -f "$HOME/.personal" ]]; then
    # Bit of a hack to avoid pulling twice on non-personal machine since these
    # should be added to `egit` on those machines
    exit 0
  fi
fi

~/.bin/check_repos

~/.bin/sgitt -u
if [[ "$text_only" == "true" ]]; then
  exit 0
fi

~/.bin/sgitp -u
if [[ "$(uname)" = "Darwin" ]]; then
  ~/.bin/sgitm -u
fi
