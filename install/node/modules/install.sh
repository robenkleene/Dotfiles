#!/usr/bin/env bash

set -e

source "${BASH_SOURCE%/*}/modules.sh"

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

installed_modules=()
while IFS= read -r line; do
    installed_modules+=( "$line" )
done < <( npm ls -gp --depth=0 | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' )

for module in "${modules[@]}"; do
  if [[ ! " ${installed_modules[*]} " =~ " ${module} " ]]; then
    if $force; then
      set -x
      npm -g install "$module"
      set +x
    else
      echo "Installing $module"
    fi
  fi
done
