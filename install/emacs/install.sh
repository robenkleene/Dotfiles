#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# Use GUI Emacs CLI instead of managing a separate `brew install`
if [ ! -e /usr/local/bin/emacs ] && [ -e /Applications/Emacs.app/Contents/MacOS/emacs-nw ]; then
  # We use `emacs-nw` here because on macOS `emacs <file>` which normally opens
  # in GUI Emacs, has a couple of caveats:
  #
  # 1. The `emacs <file>` process will not exit until the frame is closed, so
  # the terminal that `emacs <file>` was run from won't be usable until the
  # frame is closed.
  #
  # 2. `emacs <file>` opens a separate instance of `Emacs.app`, so a separate
  # Dock icon will appear for example.
  #
  # For these reasons, it's generally better on macOS to have `emacs <file>`
  # behave as `emacs -nw`, and open a file in GUI Emacs with `open -a Emacs
  # <file>`
  sudo ln -s /Applications/Emacs.app/Contents/MacOS/emacs-nw /usr/local/bin/emacs
fi

exec emacs --script packages.el
