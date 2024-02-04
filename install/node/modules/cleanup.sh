#!/usr/bin/env bash

set -e

source "${BASH_SOURCE%/*}/modules.sh"

force=false
uninstall=false
while getopts ":fuh" option; do
  case "$option" in
    f)
      force=true
      ;;
    u)
      uninstall=true
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

npm ls -gp --depth=0 | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' | while IFS=$'\n' read -r module; do
  if [[ "$uninstall" == "true" ]]; then
    if $force; then
      set -x
      npm -g rm "$module"
      set +x
    else
      echo "Deleting $module"
    fi
  elif [[ ! " ${modules[*]} " =~ " ${module} " ]]; then
    if $force; then
      set -x
      npm -g rm "$module"
      set +x
    else
      echo "Deleting $module"
    fi
  fi
done

