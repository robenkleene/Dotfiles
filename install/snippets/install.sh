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
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done


cd $(dirname "$0" || exit 1)

if $force; then
  ./snippets_export.rb -f
else
  ./snippets_export.rb
fi

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo "Dry Run"
  echo
fi
rsync $dry_run ./emacs ~/.emacs.d/snippets
