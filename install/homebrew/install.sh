#!/usr/bin/env bash

set -euo pipefail

cleanup=""
while getopts ":mch" option; do
  case "$option" in
    c)
      cleanup="cleanup -f"
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

if [[ "$(uname)" = "Darwin" ]]; then
  # if [[ -f "$HOME/.personal" ]]; then
    cd macos
    brew bundle "$cleanup"
  # else
  #   cd macos
  #   brew bundle "$cleanup"
  # fi
elif [[ "$(uname)" = "Linux" ]]; then
  if [[ -f "$HOME/.personal" ]]; then
    cd linux
    brew bundle "$cleanup"
  else
    cd minimal
    brew bundle "$cleanup"
  fi
else
  echo "Error: Unsupported platform" >&2
  exit 1
fi
