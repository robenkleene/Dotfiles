#!/usr/bin/env bash

set -euo pipefail

export BROWSER="" 
exec gh pr view --web
