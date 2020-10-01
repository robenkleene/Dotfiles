#!/usr/bin/env bash

set -e

git remote rm origin
git remote add origin "$1"
