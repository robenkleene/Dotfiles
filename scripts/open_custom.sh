#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  ~/.bin/finder_new
else
  if [[ ! -e "$1" ]]; then
    touch "$1"
  fi
  open "$1"
fi
