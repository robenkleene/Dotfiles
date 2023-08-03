#!/usr/bin/env bash

python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
