#!/bin/bash

set -e

cd "$(dirname "$0")" || exit 1

function make_symlink() {
  source=.$1
  destination=~/.$1
  if [ !-e "$destination" ]; then
    echo $source $destination
    #    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    echo "ERROR: $destination is a file and it's not a symlink!"
  fi
}

for thisFILE in *; do 
  if [[ ! $thisFILE =~ ".sh" ]]; then
    # Exclude shell scripts
    if [[ ! $thisFILE =~ "scripts" ]]; then
      # Exclude the scripts directory
      make_symlink "$thisFILE"
    fi
  fi
done

./Scripts/install.sh
