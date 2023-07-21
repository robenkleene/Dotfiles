#!/usr/bin/env bash

set -euo pipefail

files="false"
recursive="false"
while getopts ":frh" option; do
  case "$option" in
    r)
      recursive="true"
      ;;
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

type=""
if [[ "$files" == "true" ]]; then
  type=" --type f "
fi

depth=" --max-depth 1 "
if [[ "$recursive" == "true" ]]; then
  depth=""
fi

exec fd${type} --strip-cwd-prefix --follow --color=always --hidden${depth} --exclude .DS_Store --exclude .git --exclude .hg
