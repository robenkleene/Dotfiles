#!/usr/bin/env python3
"""Edit a file in the host nvim instance."""
from __future__ import print_function
import os
import sys

from neovim import attach

args = sys.argv[1:] or [""]

addr = os.environ.get("NVIM_LISTEN_ADDRESS", None)
if not addr:
    # Just use `nvim` if no host exists
    os.execvp('nvim', args)

nvim = attach("socket", path=addr)
ldir = os.getcwd()

nvim.input('<c-\\><c-n>')  # exit terminal mode
nvim.command('exe "lcd " fnameescape("' + ldir + '")')
for x in args:
    nvim.command('exe "drop " fnameescape("' + x + '")')
