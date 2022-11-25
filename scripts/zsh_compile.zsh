#!/usr/bin/env zsh

set -euo pipefail

cd
zcompile .zshenv
zcompile .zshrc
cd ~/.zsh
for f in *.zsh; do zcompile "$f"; done
