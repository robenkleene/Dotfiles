#!/usr/bin/env bash

set -euo pipefail

log="$HOME/Text/journal/time.csv"
while getopts ":p:h" option; do
  case "$option" in
    p)
      log="$OPTARG"
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

echo "$(date)", "$1" > "$log"
