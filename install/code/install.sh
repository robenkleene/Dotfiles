#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0" || exit 1)"

# VS Code
vscode_path="$HOME/.config/Code"
vscode_insiders_path="$HOME/.config/Code - Insiders"
if [[ -e "$vscode_path" && ! -e "$vscode_insiders_path" ]]; then
  ln -s "$vscode_path" "$vscode_insiders_path"
else
  # TODO warn about not symlink
fi
if [[ ! -e "$vscode_path/User/snippets/global.code-snippets" ]]; then
  ln -s "$vscode_path/User/snippets/global.json" "$vscode_path/User/snippets/global.code-snippets"
else
  # TODO warn about not symlink
fi
if [[ "$(uname)" = "Darwin" ]]; then
  if [[ ! -e "$HOME/Library/Application Support/Code" ]]; then
    ln -s "$vscode_path" "$HOME/Library/Application Support/Code"
  else
    # TODO warn about not symlink
  fi
  if [[ ! -e "$HOME/Library/Application Support/Code - Insiders" ]]; then
    ln -s "$vscode_path" "$HOME/Library/Application Support/Code - Insiders"
  else
    # TODO warn about not symlink
  fi
fi

cd $(dirname "$0" || exit 1)
if [[ "\$(uname)" = "Darwin" ]]; then
  if [[ "$HOME/.vscode/extensions/" ]]; then
    if [[ ! -e "$HOME/.vscode/extensions/robenkleene.robenkleene-0.0.1/" ]]; then
      ln -s vscode-robenkleene/ "$HOME/.vscode/extensions/robenkleene.robenkleene-0.0.1/"
    else
      # TODO warn about not symlink
    fi
  elif [[ "\$(uname)" = "Linux" ]]; then
    if [[ ! -e "$HOME/.vscode-server/extensions/robenkleene.robenkleene-0.0.1/" ]]; then
      ln -s vscode-robenkleene/ "$HOME/.vscode-server/extensions/robenkleene.robenkleene-0.0.1/"
    else
      # TODO warn about not symlink
    fi
  fi
fi

./extensions/install.sh
