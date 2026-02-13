#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# Brew

# Give a consistent path for brew installs
brew_bin_dir="$HOME/.brew"
brew_bin="$brew_bin_dir/bin"
brew_share="$brew_bin_dir/share"
if [[ ! -e "$brew_bin" || ! -e "$brew_share" ]]; then
  if [[ -e "/usr/local/bin/brew" ]]; then
    brew_prefix=$(/usr/local/bin/brew --prefix)
  elif [[ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    brew_prefix=$(/home/linuxbrew/.linuxbrew/bin/brew --prefix)
  elif [[ -e "/opt/homebrew/bin/brew" ]]; then
    brew_prefix=$(/opt/homebrew/bin/brew --prefix)
  elif [[ -e "$HOME/.brew/bin/brew" ]]; then
    brew_prefix=$("$HOME/.brew/bin/brew" --prefix)
  fi

  if [[ -n $brew_prefix ]]; then
    echo "Error: No brew prefix found" >&2
    exit 1
  fi

  brew_prefix_bin="$brew_prefix/bin"
  if [[ ! -e "$brew_prefix_bin" ]]; then
    echo "Error: $brew_prefix_bin does not exist" >&2
    exit 1
  fi

  # `cmake` was exiting if `share` wasn't also created relatively
  brew_prefix_share="$brew_prefix/share"
  if [[ ! -e "$brew_prefix_share" ]]; then
    echo "Error: $brew_prefix_share does not exist" >&2
    exit 1
  fi

  if [[ ! -e "$brew_bin_dir" ]]; then
    mkdir -p "$brew_bin_dir"
  fi
  ln -s "$brew_prefix_bin" "$brew_bin"
  ln -s "$brew_prefix_share" "$brew_share"
fi

./link_user_brew.sh

# `rust-lldb` needs `lldb` to be the command
# Do this here so `./link_user_brew.sh` can create `/usr/local/bin`
if [[ "$(uname)" = "Linux" ]]; then
  # `lldb-6.0` is installed by default on Ubuntu
  if [[ ! -e "/usr/local/bin/lldb" ]]; then
    sudo ln -s "/usr/bin/lldb-6.0" "/usr/local/bin/lldb"
  fi
  if [[ ! -e "/usr/local/bin/clangd" ]]; then
    sudo ln -s "/usr/bin/clangd-10" "/usr/local/bin/clangd"
  fi
fi
