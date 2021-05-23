#!/usr/bin/env bash

set -euo pipefail

cleanup=""
while getopts ":ch" option; do
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

if [[ -n "$CODESPACES" ]]; then
  cd vscode
  brew bundle "$cleanup"
elif [[ -n "$PERSONAL" && "$(uname)" = "Darwin" ]]; then
  cd personal
  brew bundle "$cleanup"
elif [[ "$(uname)" = "Darwin" ]]; then
  cd macos
  brew bundle "$cleanup"
elif [[ "$(uname)" = "Linux" ]]; then
  cd linux
  brew bundle "$cleanup"
else
  echo "Error: Unsupported platform" >&2
  exit 1
fi
