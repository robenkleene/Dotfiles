#!/usr/bin/env bash

set -e

source "${BASH_SOURCE%/*}/packages.sh"
source "${BASH_SOURCE%/*}/checks.sh"
check_paths

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

if ! command -v pipdeptree &> /dev/null; then
  echo "pipdeptree is not installed, run install first" >&2
  exit 1
fi

if ! command -v pip-autoremove &> /dev/null; then
  echo "pip-autoremove is not installed, run install first" >&2
  exit 1
fi

pipdeptree --user-only | grep -v "^\s" | cut -d "=" -f 1 | while IFS=$'\n' read -r module; do
  if [[ ! " ${modules[*]} " =~ " ${module} " ]]; then
    if $force; then
      set -x
      pip-autoremove --yes "$module"
      set +x
    else
      echo "Deleting $module"
    fi
  fi
done


