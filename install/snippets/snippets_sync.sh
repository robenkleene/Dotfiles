#!/usr/bin/env bash

set -euo pipefail

force="false"
delete="false"
while getopts ":dfh" option; do
  case "$option" in
    d)
      delete="true"
      ;;
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

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo
  echo "Sync Dry Run"
  echo
fi

delete_option=""
if $delete; then
  delete_option="--delete"
fi

rsync $dry_run $delete_option --archive --verbose ./emacs/ ~/.emacs.d/snippets/
