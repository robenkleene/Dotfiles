#!/usr/bin/env bash

set -e

git ls-remote --get-url | tr -d '\n'
