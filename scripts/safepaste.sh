#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
	pbpaste
elif [ -n "$TMUX" ]; then
	tmux saveb -
else
	echo ''
fi

