# bind \t accept-autosuggestion
# This conflicts with using the kill ring, use `\cv` instead
bind \cy fish_safepaste
# bind \cY yank
bind \cv fish_safepaste
bind \cq push_line
bind \cw backward-kill-bigword
# Give visual feedback on copy by also killing the line
# bind \cx 'fish_clipboard_copy; commandline -f kill-whole-line'
# bind \cx 'fish_cmdline_safecopy; commandline -f kill-whole-line'
bind \er 'open .'
# This conflicts with cut, just use the native bindings of `\ee` or `\ev`
bind \cx\ce edit_command_buffer
# bind \cx\cx 'fish_cmdline_safecopy; commandline -f kill-whole-line'
# New approach that works for multi-line prompts
bind \cx\cx 'fish_cmdline_safecopy; commandline ""; commandline -f repaint'
# This fails occassionaly, and running the same command manually with single
# quotes instead of double around the term seems to fix it
bind \cx\cd 'history delete --exact --case-sensitive "(commandline)"; commandline -f kill-whole-line'
# This is how you bind `C-space` but the selection works funny
# bind -k nul begin-selection
# unbind
# These characters sometimes get input from macOS's accented character system
bind ˜ true
bind õ true
bind ã true
bind ñ true
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
