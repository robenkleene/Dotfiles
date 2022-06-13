#!/usr/bin/env bash

set -euo pipefail

# Make aliases compatible with Spotlight
# This alias doesn't work great either, because it doesn't display the correct
# icon, and it isn't prioritized as the first action the way other applications
# are. Instead just reveal the `.app`  and copy it into the `/Applications`
# folder.
# osascript -e 'tell application "Finder" to make alias file to POSIX file "/opt/homebrew/Cellar/emacs-plus@28/28.1/Emacs.app" at POSIX file "/Applications"'
