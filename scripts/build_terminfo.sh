#!/usr/bin/env bash

# Build a `.terminfo' that will support colors and underline at the same time
# in `tmux':
{ infocmp -x screen-256color; printf '\t%s\n' 'ncv@,'; } > /tmp/t && tic -x /tmp/t
