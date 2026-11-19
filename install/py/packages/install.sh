#!/usr/bin/env bash

set -e

source "${BASH_SOURCE%/*}/packages.sh"

force=false
while getopts ":fh" option; do
  case "$option" in
    f)
      force=true
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

if ! $force; then
  echo "Dry Run"
  echo
fi

installed=()
while IFS= read -r line; do
  installed+=("$line")
done < <(installed_tools)

for entry in "${tools[@]}"; do
  tool="${entry%% *}"
  if [[ ! " ${installed[*]} " =~ " ${tool} " ]]; then
    if $force; then
      set -x
      uv tool install "${entry#* }"
      set +x
    else
      echo "Installing $tool"
    fi
  fi
done
