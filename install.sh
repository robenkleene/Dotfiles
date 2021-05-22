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

# Codespaces already has these files, archive the existing ones first
function cleanup_file() {
  filename="$1"
  if [[ -e "$filename" && ! -L "$filename" ]]; then
    mkdir -p "$HOME/backup"
    mv "$filename" "$HOME/backup/"
  fi
}
cleanup_file "$HOME/.zshrc"
cleanup_file "$HOME/.config"
cleanup_file "$HOME/.gitconfig"

./update.sh
./install/files/dirs.sh
./install/files/symlinks.sh
./install/homebrew/install.sh
./install/node/install.sh
./install/ruby/install.sh
./install/python/install.sh
