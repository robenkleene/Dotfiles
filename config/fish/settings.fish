set fish_escape_delay_ms 200

# Quick hack to prevent fish from inhereting VIM_COMMAND from a parent `zsh` session
set --global --erase VIM_COMMAND

# Implement `!!`
# Don't think we need this?
# function bangbang --on-event fish_postexec
#     alias !!="$argv[1]"
# end

