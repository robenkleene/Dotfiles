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

if [[ ! -f "$HOME/.personal" ]]; then
  ./minimal/setup.sh
fi
./update.sh

./files/dirs.sh
./repos/install.sh

if [[ ! -e "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

export PATH="~/.brew/bin/:$PATH"

# Use nvim to test whether brew install has already run
if ! command -v nvim &> /dev/null; then
  # Let homebrew fail because it fails too often
  ./homebrew/install.sh || true
fi

./files/symlinks.sh
./node/install.sh
./ruby/install.sh
./python/install.sh
./rust/install.sh
./man/install.sh
./snippets/install.sh
./emacs/install.sh
./helix/install.sh
if [[ "$(uname)" = "Darwin" ]]; then
  ./macos/install.sh
fi
