#!/usr/bin/env bash

set -e

cd ~/Documentation/ && "$HOME/.bin/sgit" "$@"
cd ~/Text/ && "$HOME/.bin/sgit" "$@"
