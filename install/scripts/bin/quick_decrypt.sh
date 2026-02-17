#!/usr/bin/env bash

set -e

if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: quick_decrypt <file.enc> <file.txt>"
  exit 1
fi

openssl enc -d -aes-256-cbc -in "$1" -out "$2"
