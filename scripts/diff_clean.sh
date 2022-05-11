#!/usr/bin/env bash

set -euo pipefail

sed '/^[+\-]Subproject commit /d'
