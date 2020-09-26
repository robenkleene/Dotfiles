#!/bin/bash

install_directory_name="Dotfiles" # The name of the directory to install from.

# Stop if this is being run from any directory besides the install directory
directory=${PWD}
directory_name=${PWD##*/}
if [ ! "$directory_name" == $install_directory_name ]; then
  echo "ERROR: This directory \"$directory_name\" doesn't match $install_directory_name."
  echo "This script only runs from the $install_directory_name directory."
  exit 1
fi

function make_symlink {
  destination=~/.$1
  if [ -f "$destination" ] || [ -d "$destination" ]; then
    if [ ! -L "$destination" ]; then
      echo "ERROR: $destination is a file and it's not a symlink!"
    fi
  else
    ln -s "$directory/$1" "$destination"
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

cd scripts || exit
./install.sh
