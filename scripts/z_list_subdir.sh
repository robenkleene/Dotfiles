#!/usr/bin/env bash

set -euo pipefail

~/.brew/bin/zoxide query --list "$@" | grep "^${PWD}" | sed -e "s#^${PWD}##" | grep . | sed "s/.//"
#                                      ^ Only match in this dir
#                                                       ^ Remove PWD from start of path
#                                                                              ^ Remove blank lines
#                                                                                       ^ Remove starting slash
