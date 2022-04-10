#!/bin/bash
set -euo pipefail

force="false"
while getopts ":fh" option; do
  case "$option" in
    f)
      force="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done

coc_extensions_path=~/.config/coc/extensions
vimrc_path=~/Developer/Dotfiles/vim/plugin/plugins/coc.vim

echo "Comparing CoC extensions list with installed extensions"
expected=$(grep -ioh "'coc-.*'" $vimrc_path | tr -d "'" | sort)
actual=$(jq -r ".dependencies | keys | sort | .[]" "$coc_extensions_path/package.json")

if [[ "$expected" != "$actual" ]]; then
    diff <(echo "$expected") <(echo "$actual")
fi
