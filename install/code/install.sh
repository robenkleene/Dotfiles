#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0" || exit 1)"

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

command -v code-insiders && code-insiders --install-extension build/robenkleene.vsix;
command -v code && code --install-extension build/robenkleene.vsix;