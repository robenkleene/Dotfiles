function fish_edit_config
    cd ~/.config/fish/
    set -q EDITOR || set EDITOR vim
    eval $EDITOR config.fish
end
