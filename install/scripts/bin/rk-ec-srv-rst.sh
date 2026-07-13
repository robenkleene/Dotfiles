#!/usr/bin/env bash

set -euo pipefail

~/.bin/ec-srv-qui
exec emacsclient -nw .
