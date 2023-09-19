#!/usr/bin/env bash

set -euo pipefail

rg --no-heading --with-filename --line-number --color=always 'https?://?([\da-z\.-]+)\.([a-z\.]{2,6})([/\w \.-]*)*/?'
