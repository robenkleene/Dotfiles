# bind \t accept-autosuggestion
bind \cq push_line
# Merge history first when doing a search
# bind -k up 'history --merge ; up-or-search'
# For some reason the above doesn't get picked up, but below does
bind \e\[A 'history --merge ; up-or-search'
