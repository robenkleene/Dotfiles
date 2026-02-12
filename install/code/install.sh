#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0" || exit 1)"

safe_symlink() {
  local src="$1"
  local dest="$2"
  if [[ ! -e "$dest" ]]; then
    ln -s "$src" "$dest"
  elif [[ ! -L "$dest" ]]; then
    echo "Warning: $dest exists and is not a symlink" >&2
  fi
}

# VS Code
vscode_path="$HOME/.config/Code"
vscode_insiders_path="$HOME/.config/Code - Insiders"
if [[ -e "$vscode_path" ]]; then
  safe_symlink "$vscode_path" "$vscode_insiders_path"
fi
safe_symlink "$vscode_path/User/snippets/global.json" "$vscode_path/User/snippets/global.code-snippets"
if [[ "$(uname)" = "Darwin" ]]; then
  safe_symlink "$vscode_path" "$HOME/Library/Application Support/Code"
  safe_symlink "$vscode_path" "$HOME/Library/Application Support/Code - Insiders"
fi

if [[ "$(uname)" = "Darwin" ]]; then
  if [[ -d "$HOME/.vscode/extensions/" ]]; then
    safe_symlink vscode-robenkleene/ "$HOME/.vscode/extensions/robenkleene.robenkleene-0.0.1"
  fi
elif [[ "$(uname)" = "Linux" ]]; then
  if [[ -d "$HOME/.vscode-server/extensions/" ]]; then
    safe_symlink vscode-robenkleene/ "$HOME/.vscode-server/extensions/robenkleene.robenkleene-0.0.1"
  fi
fi

if [[ "$(uname)" = "Darwin" ]]; then
  ./extensions/install.sh
fi
