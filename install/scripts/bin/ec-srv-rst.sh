#!/usr/bin/env bash

set -euo pipefail

~/.bin/ec_srv_qui
exec emacsclient -nw .
