# bind \t accept-autosuggestion
bind \cy fish_clipboard_paste
bind \cv vim_grep_clipboard
bind \cq push_line
bind \cw backward-kill-bigword
# Give visual feedback on copy by also killing the line
bind \ew 'fish_clipboard_copy; commandline -f kill-whole-line'
# bind \ew fish_clipboard_copy
bind \cx\ce edit_command_buffer

# unbind
# These characters sometimes get input from macOS's accented character system
bind ˜ true
bind õ true
# Merge history first when doing a search
# bind -k up 'history --merge ; up-or-search'
# For some reason the above doesn't get picked up, but below does
# This isn't so great, because if you have two sessions you're working in, you
# want "up-or-search" to return the previous command.
# bind \e\[A 'history --merge ; up-or-search'

# These aren't support until Fish 3.2 and then should be built-in
# bind \c_ undo
# bind \c_ undo
# bind \e/ redo
