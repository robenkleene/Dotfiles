#!/usr/bin/env bash

set -euo pipefail

# Brew

# Give a consistent path for brew installs
brew_bin_dir="$HOME/.brew"
brew_bin="$brew_bin_dir/bin"
if [[ -e "$brew_bin" ]]; then
  exit 0
fi

if [[ -e "/usr/local/bin/brew" ]]; then
  brew_prefix=$(/usr/local/bin/brew --prefix)
elif [[ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  brew_prefix=$(/home/linuxbrew/.linuxbrew/bin/brew --prefix)
fi
brew_prefix_bin="$brew_prefix/bin"
if [[ ! -e "$brew_prefix_bin" ]]; then
  echo "Error: $brew_prefix_bin does not exist" >&2
  exit 1
fi

if [[ ! -e "$brew_bin_dir" ]]; then
  mkdir -p "$brew_bin_dir"
fi
ln -s "$brew_prefix_bin" "$brew_bin"

# VS Code

# Link VS Code so that there's the same directory on Linux and macOS
if [[ "$(uname)" = "Darwin" ]]; then
  vscode_path="$HOME/.config/Code"
  if [[ ! -e "$vscode_path/User" ]]; then
    mkdir -p "$vscode_path"
    ln -s "$HOME/Library/Application Support/Code/User" "$vscode_path/User"
  fi
  vscode_insiders_path="$HOME/.config/Code - Insiders/"
  if [[ ! -e "$vscode_insiders_path/User" ]]; then
    mkdir -p "$vscode_insiders_path"
    ln -s "$HOME/Library/Application Support/Code - Insiders/User" "$vscode_insiders_path/User"
  fi
fi

