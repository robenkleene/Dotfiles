#!/usr/bin/env bash

set -e

source "${BASH_SOURCE%/*}/../_setup-pyenv.sh"
source "${BASH_SOURCE%/*}/packages.sh"
# `check_paths` appears to be superfluous after starting to use `pyenv`?
# source "${BASH_SOURCE%/*}/checks.sh"
# check_paths

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

if ! python3 -m pipdeptree --version &> /dev/null; then
  echo "pipdeptree is not installed, run install first" >&2
  exit 1
fi

if ! python3 -m pip show pip-autoremove &> /dev/null; then
  echo "pip-autoremove is not installed, run install first" >&2
  exit 1
fi

top_level_modules | while IFS=$'\n' read -r module; do
  if [[ ! " ${module_names[*]} " =~ " ${module} " ]]; then
    if [ "$module" = "wheel" ]; then
      # `wheel` appears to be auto-installed?
      continue
    elif $force; then
      set -x
      pip-autoremove --yes "$module"
      set +x
    else
      echo "Deleting $module"
    fi
  fi
done
