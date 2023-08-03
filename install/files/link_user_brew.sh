#!/usr/bin/env bash

set -euo pipefail

# Anything that's used as a shell needs a absolute path that's not specific to
# one username

default_brew_bin=/usr/local/bin
if [[ ! -e "$default_brew_bin" ]]; then
  mkdir -p "$default_brew_bin"
elif [[ ! -d "$default_brew_bin" ]]
  echo "$default_brew_bin exists but isn't a directory" >&2
  exit 1
fi

if [[ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  brew_prefix=$(/home/linuxbrew/.linuxbrew/bin/brew --prefix)
elif [[ -e "/opt/homebrew/bin/brew" ]]; then
  brew_prefix=$(/opt/homebrew/bin/brew --prefix)
elif [[ -e "$HOME/.brew/bin/brew" ]]; then
  brew_prefix=$(~/.brew/bin/brew --prefix)
else
  echo "Skipping, No alternative directory found" >&2
  exit 0
fi

user_brew_bin="$brew_prefix/bin"
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
link_app tmux
link_app zsh
link_app nu
