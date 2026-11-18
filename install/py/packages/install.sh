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

pip3_install() {
  if [[ -z "$1" ]]; then
    echo "No package specified"
  fi
  python3 -m pip install --user "$1"
}

if ! python3 -m pipdeptree --version &> /dev/null; then
  if ! $force; then
    echo "pipdeptree is required to continue" >&2
    exit 1
  fi
  pip3_install pipdeptree
  if ! python3 -m pipdeptree --version &> /dev/null; then
    echo "Installing pipdeptree failed" >&2
    exit 1
  fi
fi

installed_modules=()
while IFS= read -r line; do
    installed_modules+=( "$line" )
done < <( top_level_modules )

for entry in "${modules[@]}"; do
  module="${entry%% *}"
  if [[ ! " ${installed_modules[*]} " =~ " ${module} " ]]; then
    if $force; then
      set -x
      pip3_install "${entry#* }"
      set +x
    else
      echo "Installing $module"
    fi
  fi
done
