#!/usr/bin/env bash

set -euo pipefail

nvm use v13.12.0 || nvm install v13.12.0

cd "$(dirname "$0")" || exit 1
./modules/install.sh
