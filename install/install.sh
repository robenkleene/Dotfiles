#!/usr/bin/env bash

# Can't include `e` because the `command -v fish` below can fail
set -uo pipefail

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
  PERSONAL=1
fi

cd "$(dirname "$0")" || exit 1

if [[ -n "${CODESPACES-}" ]]; then
  ./codespaces/setup.sh
fi
./update.sh

if [[ -n "${CODESPACES:-}" ]]; then
  exit 0
fi

./files/dirs.sh
if [[ -n "${PERSONAL:-}" ]]; then
  ./repos/install.sh
else
  ./repos/install.sh -p
fi

if [[ "$(uname)" = "Darwin" ]]; then
  ./settings/macos/install.sh
fi

export PATH="~/.brew/bin/:$PATH"

# Use fish to test whether brew install has already run
if ! command -v fish &> /dev/null; then
  # Let homebrew fail because it fails too often
  ./homebrew/install.sh || true
else
  ./fish/setup.sh
fi

./files/symlinks.sh
./node/install.sh
./ruby/install.sh
./python/install.sh
./rust/install.sh
./man/install.sh