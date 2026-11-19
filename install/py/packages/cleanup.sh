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

installed_tools | while IFS= read -r tool; do
  if [[ ! " ${tool_names[*]} " =~ " ${tool} " ]]; then
    if $force; then
      set -x
      uv tool uninstall "$tool"
      set +x
    else
      echo "Uninstalling $tool"
    fi
  fi
done
