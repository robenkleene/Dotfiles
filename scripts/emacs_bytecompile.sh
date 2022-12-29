#!/usr/bin/env bash

set -euo pipefail

verbose="false"
clean="false"
while getopts ":cvh" option; do
  case "$option" in
    v)
      verbose="true"
      ;;
    c)
      clean="true"
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

if [[ "$clean" == "true" ]]; then
  find ~/.emacs.d/robenkleene -name "*.elc" -type f -delete
else
  find ~/.emacs.d/robenkleene -name "*.elc" -type f | while read -r line; do
    if [[ ! -f "${line%?}" ]]; then
      rm "$line"
    fi
  done
fi

redirect=" 2> /dev/null"
if [[ "$verbose" == "true" ]]; then
  redirect=""
fi
eval "emacs --batch -nw -eval '(byte-recompile-directory (expand-file-name \"~/.emacs.d/robenkleene\") 0)' $redirect"
