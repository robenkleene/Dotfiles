#!/usr/bin/env bash

set -e

if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: quick_encrypt <file.txt> <file.enc>"
  exit 1
fi

openssl enc -aes-256-cbc -salt -in "$1" -out "$2"
