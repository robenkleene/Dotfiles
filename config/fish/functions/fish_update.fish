function fish_update
    fish_sync_alias >/dev/null
    fish_sync_variables
    fish_sync_abbr
    fish_set_colors
    fish_set_user_paths
    # Can't source aliases this way because aliases aren't global
    # source ~/.config/fish/alias.fish
end
