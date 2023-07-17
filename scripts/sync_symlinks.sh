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

if [[ "$force" != "true" ]]; then
  echo "Dry Run"
  echo
fi

function make_symlink() {
  source="$1"
  destination="$2"
  if [ -e "$destination" ] && [ ! -L "$destination" ]; then
    echo "Warning: $destination already exists and it's not a symlink" >&2
  else
    if [ ! -e "$destination" ]; then
      if [[ "$force" == "true" ]]; then
        ln -s "$source" "$destination"
      else
        echo "Linking $source to $destination"
      fi
    fi
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

cd "$src"
for file in *; do
  if [ -d "$file" ]; then
    continue
  fi

  make_symlink "$src/$file" "$dst/$file"
done
cd - >/dev/null

# Cleanup dead symlinks
cd "$dst"
if [[ "$force" == "true" ]]; then
    find -L . -name . -o -type d -prune -o -type l -exec rm {} +
else
  find -L . -name . -o -type d -prune -o -type l -exec echo Deleting {} +
fi
