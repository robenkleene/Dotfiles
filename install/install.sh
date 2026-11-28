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

# Migrate the old name for the personal machine marker file
if [[ -f "$HOME/.personal" && ! -e "$HOME/.robenkleene" ]]; then
  mv "$HOME/.personal" "$HOME/.robenkleene"
fi

if [[ "$main" == "true" && ! -e "$HOME/.robenkleene" ]]; then
  touch "$HOME/.robenkleene"
fi

cd "$(dirname "$0")" || exit 1

./files/prepare.sh
./update.sh

./files/dirs.sh
./repos/install.sh

export PATH="~/.brew/bin/:$PATH"

# Use `rg` to test whether brew install has already run
if ! command -v rg &> /dev/null; then
  # Let homebrew fail because it fails too often
  ./brew/install.sh || true
fi

./files/symlinks.sh
./claude/install.sh
./code/install.sh
./codex/install.sh
./emacs/install.sh
./node/install.sh
./py/install.sh
./rb/install.sh
./rs/install.sh
./vim/install.sh
./yazi/install.sh

if [[ "$(uname)" = "Darwin" ]]; then
  ./macos/install.sh
fi

