#!/usr/bin/env bash

set -e

while [[ $PWD != / ]]; do
  if [[ -f tags ]]; then
    break
  fi
  cd ..
done

emacs="false"
if ls | grep "^TAGS$" 2>&1 >/dev/null; then
  emacs="true"
fi

if "$emacs" == "true"; then
  cat TAGS | grep '' | cut -f 1 -d $'' | awk '{$1=$1};1'
else
  ~/Development/Dotfiles/vim/plugged/fzf.vim/bin/tags.pl tags |\
    cut -f 1 | cut -f 1 -d$ | cut -f 1 -d' '
fi

if [[ $PWD == / ]]; then
  echo "No tags file found" >&2
fi
