#!/usr/bin/env bash

set -e

documentation="$HOME/Documentation/"

diff <(sort < documentation.txt) <(~/.bin/git_sync_remotes "$documentation" | sort)
