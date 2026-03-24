#!/usr/bin/env bash

set -e

cd ~/Downloads/

for var in "$@"
do
  curl --remote-name --location "$var"
done
