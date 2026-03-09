#!/usr/bin/env bash

set -euo pipefail

cd $(dirname "$0" || exit 1)

source ~/.bin/nobin/_symlink.sh

applescripts_path="$HOME/Library/Scripts"
safe_symlink "$PWD/Scripts" "$applescripts_path"

services_path="$HOME/Library/Services"
safe_symlink "$PWD/Services" "$services_path"

bbedit_path="$HOME/Library/Application Support/BBEdit"
safe_symlink "$PWD/BBEdit" "$bbedit_path"
