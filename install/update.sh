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

# Claude must happen before other dotfiles to support custom install locations
../install/claude/install.sh

cd ..

source_dir=$(pwd -P);

# Cleanup dead symlinks
find -L "$HOME" -maxdepth 1 -type l -exec rm {} +

function make_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    # Ignore claude to allow multiple installation approaches
    if [ "$destination" != "$HOME/.claude" ]; then
      echo "Warning: $destination exists and it's not a symlink" >&2
    fi
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
cd - > /dev/null

# As a general rule, re-compile assets here if it's fast
# E.g., `zsh` and script symlinks
# And check-in compiled assets if it's slow
# E.g., AppleScripts, `man` pages
echo "Updating scripts..."
../install/scripts/update.sh
echo "Updating zsh..."
../install/zsh/update.zsh
echo "Updating vim..."
../install/vim/update.sh

if [[ "$all" == "false" ]]; then
  exit 0
fi

./homebrew/install.sh -c
./node/modules/update.sh -f
./rb/gems/update.sh -f
./py/packages/update.sh -f

brew update && brew upgrade
