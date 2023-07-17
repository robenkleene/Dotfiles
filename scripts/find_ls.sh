#!/usr/bin/env bash

set -euo pipefail

files="false"
while getopts ":fh" option; do
  case "$option" in
    f)
      files="true"
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

modifier=""
if [[ "$files" == "true" ]]; then
  modifier="--type f"
fi
exec fd ${modifier} --strip-cwd-prefix --follow --hidden --max-depth 1 --exclude .DS_Store --exclude .git --exclude .hg
