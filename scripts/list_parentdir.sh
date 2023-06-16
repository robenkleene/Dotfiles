#!/usr/bin/env bash

set -euo pipefail

[ "$PWD" != / ] && [ "$PWD" != "$HOME" ] && cd -P ..
while
  [ "$PWD" != / ] && [ "$PWD" != "$HOME" ]
do
 pwd
 cd -P ..
done
