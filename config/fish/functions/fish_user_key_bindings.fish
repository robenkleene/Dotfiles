# bind \t accept-autosuggestion
bind \cq push_line
# Merge history first when doing a search
# bind -k up 'history --merge ; up-or-search'
# For some reason the above doesn't get picked up, but below does
# This isn't so great, because if you have two sessions you're working in, you
# want "up-or-search" to return the previous command.
# bind \e\[A 'history --merge ; up-or-search'
