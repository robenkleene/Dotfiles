#!/usr/bin/env bash

set -euo pipefail

skip_system="false"
while getopts ":sh" option; do
  case "$option" in
    s)
      skip_system="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Have to pipe to both `tmux loadb -` and clipboard file because `tmux loadb
# -` will succeed if tmux is running even if not currently attached to a
# session
# Can't depend on `TMUX` running when `EMCSSERVER` is set because that
# variable is recorded when the emacs server was started
if [[ -n "${EMACSSERVER:-}" ]]; then
  if [ "$(uname)" = "Darwin" ] && command -v pbpaste &> /dev/null && [ "$skip_system" == "false" ]; then
    tee >(pbcopy) | tmux loadb -w -
  elif [[ "$skip_system" == "false" ]]; then
    tmux loadb -w -
  else
    tmux loadb -
  fi
elif [[ -n "${TMUX:-}" ]]; then
  if [[ "$skip_system" == "false" ]]; then
    if [[ "${__CFBundleIdentifier:-}" = "com.apple.Terminal" ]]; then
      # Apple Terminal doesn't support built-in clipboard support
      tee >(tmux loadb -) | pbcopy
    else
      tmux loadb -w -
    fi
  else
    tmux loadb -
  fi
elif [ "$(uname)" = "Darwin" ] && command -v pbcopy &> /dev/null && [ "$skip_system" == "false" ]; then
  pbcopy
else
  base64 -w 0 | xargs printf "\\e]52;c;%s\\a" >&2 >/dev/tty
fi
