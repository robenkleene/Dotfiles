#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# Brew

# Give a consistent path for brew installs
brew_bin_dir="$HOME/.brew"
brew_bin="$brew_bin_dir/bin"
if [[ ! -e "$brew_bin" ]]; then
  if [[ -e "/usr/local/bin/brew" ]]; then
    brew_prefix=$(/usr/local/bin/brew --prefix)
  elif [[ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    brew_prefix=$(/home/linuxbrew/.linuxbrew/bin/brew --prefix)
  elif [[ -e "/opt/homebrew/bin/brew" ]]; then
    brew_prefix=$(/opt/homebrew/bin/brew --prefix)
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
fi

# VS Code
vscode_path="$HOME/.config/Code"
vscode_insiders_path="$HOME/.config/Code - Insiders"
if [[ -e "$vscode_path" && ! -e "$vscode_insiders_path" ]]; then
  ln -s "$vscode_path" "$vscode_insiders_path"
fi
if [[ ! -e "$vscode_path/User/snippets/global.code-snippets" ]]; then
  ln -s "$vscode_path/User/snippets/global.json" "$vscode_path/User/snippets/global.code-snippets"
fi
if [[ "$(uname)" = "Darwin" ]]; then
  if [[ ! -e "$HOME/Library/Application Support/Code" ]]; then
    ln -s "$vscode_path" "$HOME/Library/Application Support/Code"
  fi
  if [[ ! -e "$HOME/Library/Application Support/Code - Insiders" ]]; then
    ln -s "$vscode_path" "$HOME/Library/Application Support/Code - Insiders"
  fi
fi

# Nushell
if [[ "$(uname)" = "Darwin" ]]; then
  if [[ -e "$HOME/.config/nushell" && ! -e "$HOME/Library/Application Support/nushell" ]]; then
    ln -s "$HOME/.config/nushell" "$HOME/Library/Application Support/nushell"
  fi
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
