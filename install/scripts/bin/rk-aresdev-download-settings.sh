#!/usr/bin/env bash

set -euo pipefail

ssh aresdev 'cd ~/Developer/Settings/ && ~/.bin/rk-git-archive'
sftp aresdev:Developer/Settings/Settings.tar.gz .
ssh aresdev 'rm ~/Developer/Settings/Settings.tar.gz'
