#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

if [[ ! -e ~/.pyenv ]]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

source _setup-pyenv.sh

# An old `pyenv` checkout doesn't know about newer Python releases
if ! version=$(pyenv latest -k "$python_version" 2>/dev/null); then
  git -C "$PYENV_ROOT" pull --ff-only
  version=$(pyenv latest -k "$python_version")
fi

pyenv install --skip-existing "$version"
pyenv global "$version"

# A Python built without these modules installs fine but can't download
# packages, e.g., when the OpenSSL it was built against gets removed
if ! python3 -c 'import ssl, zlib' >/dev/null 2>&1; then
  echo "Python $version is missing the ssl or zlib module, install the build dependencies and run \`pyenv install --force $version\`" >&2
  exit 1
fi

./packages/install.sh -f "$@"
