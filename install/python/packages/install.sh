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

pip3_install() {
  if [[ -z "$1" ]]; then
    echo "No package specified"
  fi
  pip3 install --user "$1"
}

if ! command -v pipdeptree &> /dev/null; then
  if ! $force; then
    echo "pipdeptree is required to continue" >&2
    exit 1
  fi
  pip3_install pipdeptree
  if ! command -v pipdeptree &> /dev/null; then
    echo "Installing pipdeptree failed" >&2
    exit 1
  fi
fi

installed_modules=()
while IFS= read -r line; do
    installed_modules+=( "$line" )
done < <( pipdeptree --user-only | grep -v "^\s" | cut -d "=" -f 1 )

for module in "${modules[@]}"; do
  if [[ ! " ${installed_modules[*]} " =~ " ${module} " ]]; then
    if $force; then
      set -x
      pip3_install "$module"
      set +x
    else
      echo "Installing $module"
    fi
  fi
done
