# Quick hack to prevent fish from inhereting VIM_COMMAND from a parent `zsh` session
set --global --erase VIM_COMMAND
set --global --erase EDITOR
set --global --erase VISUAL

