#!/usr/bin/env bash

set -e

while [[ $PWD != / ]]; do
  if [[ -f tags ]]; then
    break
  fi
  cd ..
done

if [[ $PWD == / ]]; then
  echo "No tags file found" >&2
  exit 1
fi

emacs="false"
if ls TAG? | grep "^TAGS$" 2>&1 >/dev/null; then
  emacs="true"
fi

if "$emacs" == "true"; then
  cat TAGS | grep '' | cut -f 2 -d $'' | cut -f1 -d $''
else
  ~/Development/Dotfiles/vim/plugged/fzf.vim/bin/tags.pl tags |\
    cut -f 1 | cut -f 1 -d$ | cut -f 1 -d' '
fi
