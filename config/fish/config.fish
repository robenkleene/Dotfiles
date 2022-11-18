if test -z $TMUX
    ~/.bin/print_shell_status
end

source ~/.config/fish/settings.fish
source ~/.config/fish/installs.fish
source ~/.config/fish/fzf.fish

if test -f ~/.local.fish
    source ~/.local.fish
end
