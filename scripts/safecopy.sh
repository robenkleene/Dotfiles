#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
	pbcopy $@
elif [ -n "$TMUX" ]; then
	tmux loadb -
else
	cat >/dev/null
fi

