#!/usr/bin/env bash

set -euo pipefail

~/.bin/emacs_server_kill
exec ~/.bin/emacsclient_wrapper
