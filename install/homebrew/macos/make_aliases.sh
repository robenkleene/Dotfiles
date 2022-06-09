#!/usr/bin/env bash

set -euo pipefail

# Make aliases compatible with Spotlight

osascript -e 'tell application "Finder" to make alias file to POSIX file "/opt/homebrew/Cellar/emacs-plus@28/28.1/Emacs.app" at POSIX file "/Applications"'


