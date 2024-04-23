#!/usr/bin/env bash

set -euo pipefail

force=""
while getopts ":fh" option; do
  case "$option" in
    f)
      force="true"
      ;;
    h)
      echo "Usage: command [-hf]"
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

cd "$(dirname "$0")" || exit 1
if [[ "$force" == "true" ]]; then
  bundle clean --force
else
  bundle clean
fi

if [[ "$force" == "true" ]]; then
  ./install.sh -f
else
  ./install.sh
fi
