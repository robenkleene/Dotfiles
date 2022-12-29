#!/usr/bin/env bash

set -euo pipefail

all="false"
while getopts ":ah" option; do
  case "$option" in
    a)
      all="true"
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

source_dir=$(pwd -P);

function make_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    echo "Warning: $destination exists and it's not a symlink" >&2
  fi
}

for file in *; do
  if [[ $file == *.sh ]]; then
    continue
  fi
  if [[ $file == "scripts" ]]; then
    continue
  fi
  if [[ $file == "install" ]]; then
    continue
  fi
  if [[ $file == "README.md" ]]; then
    continue
  fi
  if [[ $file == "tags" || $file == "TAGS" ]]; then
    continue
  fi

  make_symlink "$source_dir/$file" "$HOME/.$file"
done

./scripts/update.sh
./scripts/zsh_update.zsh
# This is breaking every time it's run without the `-c` option
# ./scripts/emacs_bytecompile.sh

find -L "$HOME" -maxdepth 1 -type l -exec rm {} +

if [[ "$all" == "false" ]]; then
  exit 0
fi

./install/homebrew/install.sh -c
./install/node/modules/update.sh -f
./install/ruby/gems/update.sh -f
./install/python/packages/update.sh -f

brew update && brew upgrade
