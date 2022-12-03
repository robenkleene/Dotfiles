#!/usr/bin/env bash

set -euo pipefail

echo "bind-key -T copy-mode-vi '\"' switch-client -T copy-mode-vi-quote"
echo "bind-key '\"' switch-client -T quote"
echo

for l in {a..z}
do
  echo "bind-key -T copy-mode-vi-quote $l switch-client -T copy-mode-vi-quote-$l"
  echo "bind-key -T copy-mode-vi-quote-$l y send-keys -X pipe \"tmux loadb -b $l -\""
  echo "bind-key -T quote $l switch-client -T quote-$l"
  echo "bind-key -T quote-$l y paste-buffer -p -b $l"
  echo
done
