#!/usr/bin/env bash

set -euo pipefail

log="$HOME/Text/journal/time.csv"
while getopts ":t:p:h" option; do
  case "$option" in
    p)
      log="$OPTARG"
      ;;
    t)
      task="$OPTARG"
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

if [[ -z "${task-}" ]]; then
  echo "Error: No task" >&2
  exit 1
fi

echo "$(date)", "$task" >> "$log"
