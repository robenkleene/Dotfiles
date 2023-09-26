#!/usr/bin/env zsh

set -euo pipefail

cd
zcompile .zshenv
zcompile .zshrc
cd ~/.zsh
for f in *.zsh; do zcompile "$f"; done

# Completion

if [[ ! -e ~/.zfunc ]]; then
  mkdir ~/.zfunc
fi

# Rust
if type rustup > /dev/null; then
  rustup completions zsh cargo > ~/.zfunc/_cargo
  rustup completions zsh > ~/.zfunc/_rustup
fi

# Re-generate completion cache
# Must be run interactively because completions are only loaded that way
zsh -i -c "autoload -Uz compinit && compinit"
