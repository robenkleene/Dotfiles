#!/usr/bin/env bash

set -euo pipefail

force="false"
while getopts ":fh" option; do
  case "$option" in
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

if [[ "$force" != "true" ]]; then
  printf "Dry Run\n\n"
fi

if [[ -f "$HOME/.emacs.d/.emacs.desktop" ]]; then
  echo "Deleting $HOME/.emacs.d/.emacs.desktop"
  if [[ "$force" == "true" ]]; then
    rm "$HOME/.emacs.d/.emacs.desktop"
  fi
fi

if [[ -f "$HOME/.emacs.d/.emacs.desktop.lock" ]]; then
  echo "Deleting $HOME/.emacs.d/.emacs.desktop.lock"
  if [[ "$force" == "true" ]]; then
    rm "$HOME/.emacs.d/.emacs.desktop.lock"
  fi
fi
