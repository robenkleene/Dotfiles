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

# Migrate the old name for the personal machine marker file
if [[ -f "$HOME/.personal" && ! -e "$HOME/.robenkleene" ]]; then
  mv "$HOME/.personal" "$HOME/.robenkleene"
fi

cd "$(dirname "$0")" || exit 1

cd ..

source_dir=$(pwd -P);

echo "Updating symlinks..."

# Cleanup dead symlinks
find -L "$HOME" -maxdepth 1 -type l -exec rm {} +

# Do this here so symlink is available
echo "Updating scripts..."
$source_dir/install/scripts/update.sh

source ~/.bin/nobin/_rk-symlink.sh

for file in *; do
  if [[ $file == "install" ]]; then
    continue
  fi
  if [[ $file == "README.md" ]]; then
    continue
  fi
  if [[ $file == "tags" || $file == "TAGS" ]]; then
    continue
  fi

  safe_symlink "$source_dir/$file" "$HOME/.$file"
done
cd - > /dev/null

# As a general rule, re-compile assets here if it's fast
# E.g., `zsh` and script symlinks
# And check-in compiled assets if it's slow
# E.g., AppleScripts, `man` pages
echo "Updating zsh..."
$source_dir/install/zsh/update.zsh
echo "Updating vim..."
$source_dir/install/vim/update.sh

if [[ "$all" == "false" ]]; then
  exit 0
fi

./brew/install.sh -c
./node/modules/update.sh -f
./rb/gems/update.sh -f
# Linux without `~/.robenkleene` gets the `minimal` Brewfile, which leaves out
# `uv` to keep a quick setup light
if [[ "$(uname)" = "Darwin" || -f "$HOME/.robenkleene" ]]; then
  ./py/packages/update.sh -f
fi

brew update && brew upgrade
