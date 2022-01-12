#!/usr/bin/env bash

set -euo pipefail

dir=~/Text/journal/daily
date=$(date +%F)
filename=$date.md
filepath=$dir/$filename

browse="false"
while getopts ":bh" option; do
  case "$option" in
    b)
      browse="true"
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

if [[ ! -d "$dir" ]]; then
  echo "Error: $dir doesn't exit" >&2
  exit 1
fi

if [[ "$browse" == "true" ]]; then
  find "$dir" | sort | tail -1 | tr -d '\n'
  exit 0
fi

if [[ ! -f "$filepath" ]]; then
  echo -e "# $date\n\n" >> "$filepath"
fi
echo -n "$filepath"
