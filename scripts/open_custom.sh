#!/usr/bin/env bash

directory_extension() {
  path="$1"
  directory=${path##*/}
  extension="${directory##*.}"
  [[ $directory != "$extension" ]] && echo -n "$extension"
}

if [[ $# -eq 0 ]]; then
  # ~/.bin/finder_new
  extension=$(directory_extension "${PWD}")
  if [[ -z "$extension" ]]; then
    open .
  else
    open -R .
  fi
else
  # This has been removed because it isn't compatiable with passing flags to
  # open
  # if [[ ! -e "$1" ]]; then
  #   touch "$1"
  # fi
  open "$@"
fi
