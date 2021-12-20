#!/usr/bin/env bash

set -euo pipefail

main="false"
while getopts ":mh" option; do
  case "$option" in
    m)
      main="true"
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

if [[ "$main" == "true" && ! -e "$HOME/.personal" ]]; then
  touch "$HOME/.personal"
fi

if [[ -f "$HOME/.personal" ]]; then
  export PERSONAL=1
fi

cd "$(dirname "$0")" || exit 1

if [[ -n "${CODESPACES-}" ]]; then
  ./install/codespaces/setup.sh
fi
./update.sh

./install/files/dirs.sh
if [[ -n "${PERSONAL-}" ]]; then
  ./install/repos/install.sh
else
  ./install/repos/install.sh -p
fi

if [[ -n "${CODESPACES-}" ]]; then
  exit 0
fi

if [[ "$(uname)" = "Darwin" ]]; then
  ./install/settings/macos/install.sh
fi

export PATH="~/.brew/bin/:$PATH"
./install/homebrew/install.sh

./install/files/symlinks.sh
./install/node/install.sh
./install/ruby/install.sh
./install/python/install.sh
