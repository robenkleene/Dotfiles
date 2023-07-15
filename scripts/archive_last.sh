#!/usr/bin/env bash

set -euo pipefail

backup_root_directory=~/Archive/Text/
find "$backup_root_directory" | sort | tail -1 | tr -d '\n'
