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

cd "$(dirname "$0")" || exit 1

./files/prepare.sh
./update.sh

./files/dirs.sh
./repos/install.sh

export PATH="~/.brew/bin/:$PATH"

# Use `rg` to test whether brew install has already run
if ! command -v rg &> /dev/null; then
  # Let homebrew fail because it fails too often
  ./homebrew/install.sh || true
fi

# Do this after brew install so `tmux` is installed
./tmux/install.sh

./files/symlinks.sh
# Generate man is time consuming so check whether it's already happened
if [[ ! -e "$HOME/.man/man1/rk_vim.1" ]]; then
  ./man/install.sh
fi
./code/install.sh
./node/install.sh
./py/install.sh
./rb/install.sh
./rs/install.sh
./emacs/install.sh
./vim/install.sh

if [[ "$(uname)" = "Darwin" ]]; then
  ./macos/install.sh
fi

