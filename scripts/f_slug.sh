#!/usr/bin/env bash

set -e

while getopts ":th" option; do
  case "$option" in
    t)
      today=1
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

prefix=""
if [[ -n "${today:-}" ]]; then
  prefix="$(~/.bin/rk_today)-"
fi

# `tr -dc '[:alnum:]\r\n. '`: Strip non-alphanumeric characters
# `tr -s ' '`: Consolidate spaces to one space
# `tr '[:upper:]' '[:lower:]'`: Lowercase
# `tr ' ' '-'`: Replace spaces with hyphens
# `tr '.' '-'`: Replace period with hyphens
# `tr '/' '-'`: Replace slashes with hyphens
# `awk '{$1=$1;print}'`: Strip leading & trailing whitespace
tr -dc '[:alnum:]\r\n.\-/ ' |
  tr -s ' ' | tr '[:upper:]' '[:lower:]' | awk '{$1=$1;print}' |
  tr ' ' '-' | tr '.' '-' | tr '/' '-' | sed 's/^\-*//'
