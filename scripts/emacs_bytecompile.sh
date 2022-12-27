#!/usr/bin/env bash

set -euo pipefail

verbose="false"
while getopts ":vh" option; do
  case "$option" in
    v)
      verbose="true"
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

if [[ "$verbose" == "true" ]]; then
  emacs --batch -nw -eval '(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)'
else
  emacs --batch -nw -eval '(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)' 2> /dev/null
fi
