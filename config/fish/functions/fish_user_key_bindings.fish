# This function is called when starting a new shell session
bind \cq push_line
bind \cw backward-kill-bigword
bind \cx copy_command_line
# This fails occassionaly, and running the same command manually with single
# quotes instead of double around the term seems to fix it
# Just use `↑` `C-a` `history delete`, e.g., prefix the command to delete with `history delete`
# bind \cx\cd 'history delete --exact --case-sensitive (commandline); history save; commandline -f kill-whole-line'

# Custom function that does prefix search, the original search is still
# available with `<C-p>`
# Problem with these is that the first result is the same as autocomplete
bind -k up up_or_prefix_search
bind \e\[A up_or_prefix_search
bind -k down down_or_prefix_search
bind \e\[B down_or_prefix_search
