#!/usr/bin/env bash

set -euo pipefail

default_brew_bin=/usr/local/bin
if [[ ! -d "$default_brew_bin" ]]; then
  echo "$default_brew_bin doesn't exist" >&2
  exit 1
fi

user_brew_bin="$HOME/.brew/bin"
if [[ ! -d "$user_brew_bin" ]]; then
  echo "$user_brew_bin doesn't exist" >&2
  exit 1
fi

link_app() {
  app="$1"
  if [[ -f "$user_brew_bin/$app" ]]; then
    if [[ -f "$default_brew_bin/$app" ]]; then
      if [[ ! -L "$default_brew_bin/$app" ]]; then
        echo "Skipping $default_brew_bin/$app because there is already a file that's not a link" >&2
      else
        echo "Skipping $default_brew_bin/$app because it already is a link"
      fi
    else
      sudo ln -s "$user_brew_bin/$app" "$default_brew_bin/$app"
    fi
  else
    echo "Missing, skipping $user_brew_bin/$app"
  fi
}

link_app fish
link_app fd
link_app rg
link_app aspell
link_app tmux
