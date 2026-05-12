#!/usr/bin/env bash

set -eo pipefail

cd ~/Documentation/ && "$HOME/.bin/nobin/_sgit.sh" "$@"

if [[ ! -f "$HOME/.personal" ]]; then
  exit 0
fi

cd ~/Text/ && "$HOME/.bin/nobin/_sgit.sh" "$@"
