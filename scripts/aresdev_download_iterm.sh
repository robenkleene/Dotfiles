#!/usr/bin/env bash

set -euo pipefail

ssh aresdev 'cd ~/Developer/Settings/Apps && tar -czvf iTerm.tar.gz iTerm'
sftp aresdev:Developer/Settings/Apps/iTerm.tar.gz .
ssh aresdev 'rm ~/Developer/Settings/Apps/iTerm.tar.gz'
