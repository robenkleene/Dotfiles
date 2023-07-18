#!/usr/bin/env bash

set -euo pipefail

dir=~/Documents/Text/Notes/Journal/Daily
date=$(date +%F)
filename=$date.md
filepath=$dir/$filename

new="false"
while getopts ":nh" option; do
  case "$option" in
    n)
      new="true"
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

if [[ "$new" == "true" ]]; then
  if [[ ! -f "$filepath" ]]; then
    echo -e "# $date\n" >> "$filepath"
  fi
  echo -n "$filepath"
  exit 0
fi

find "$dir" | sort | tail -1 | tr -d '\n'
