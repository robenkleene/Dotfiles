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
    d)
      dst_path="$OPTARG"
      ;;
    s)
      src_path="$OPTARG"
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

set -x
rsync $dry_run $delete_option --archive --verbose ${src_path:-./emacs/} ${dst_path:-~/.emacs.d/snippets/}
