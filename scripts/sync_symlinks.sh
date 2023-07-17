#!/usr/bin/env bash

set -e

force="false"
while getopts ":s:d:fh" option; do
  case "$option" in
    s)
      src="$OPTARG"
      ;;
    d)
      dst="$OPTARG"
      ;;
    f)
      force="true"
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

function make_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    echo "Warning: $destination is a file and it's not a symlink" >&2
  fi
}

if [ ! -d "$src" ]; then
  echo "Source $src is not a directory" >&2
  exit 1
fi

if [ ! -d "$dst" ]; then
  echo "Destination $dst is not a directory" >&2
  exit 1
fi

for file in "$src"/*; do
  if [ -d "$file" ]; then
    continue
  fi

  make_symlink "$src/$file" "$dst/$file"
done

# Cleanup dead symlinks
cd "$dst"
if [[ "$force" == "true" ]]; then
    find -L . -name . -o -type d -prune -o -type l -exec rm {} +
else

  find -L . -name . -o -type d -prune -o -type l -exec echo "Deleting {}" +
fi
