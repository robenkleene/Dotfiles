#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

if [[ ! -e ~/.pyenv ]]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
source <(pyenv init -)

pyenv global 3.9.13 || pyenv install 3.9.13

./packages/install.sh -f "$@"
