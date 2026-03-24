#!/usr/bin/env bash

if [ ! -z "$1" ]; then
  python -m json.tool < $1
else
  python -m json.tool
fi
