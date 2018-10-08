#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
  ~/.bin/finder_new
else
  # This has been removed because it isn't compatiable with passing flags to
  # open
  # if [[ ! -e "$1" ]]; then
  #   touch "$1"
  # fi
  open "$@"
fi
