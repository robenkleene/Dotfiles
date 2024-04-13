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

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo
  echo "Sync Dry Run"
  echo
fi
rsync $dry_run --archive --verbose ./emacs/ ~/.emacs.d/snippets/
