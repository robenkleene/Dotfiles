#!/usr/bin/env bash

set -euo pipefail

public="false"
while getopts ":ph" option; do
  case "$option" in
    p)
      publich="true"
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

cd "$(dirname "$0")" || exit 1

if [[ "$public" == "true" ]]; then
  ./setup_repos.zsh -f -H -p
  ./documentation/setup.sh -f -H
else
  ./setup_repos.zsh
  ./documentation/setup.sh
fi
