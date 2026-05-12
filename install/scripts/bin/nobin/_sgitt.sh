#!/usr/bin/env bash

set -eo pipefail

if [[ ! -f "$HOME/.personal" ]]; then
  exit 0
fi

cd ~/Text/ && "$HOME/.bin/nobin/_sgit.sh" "$@"
