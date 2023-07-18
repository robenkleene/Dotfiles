# Too dangerous to run on startup in case `tmux` or `emacs` is hanging
# if test -z $TMUX
#     ~/.bin/print_shell_status
# end

source ~/.config/fish/settings.fish
source ~/.config/fish/installs.fish
source ~/.config/fish/fzf.fish
source ~/.config/fish/abbr.fish
source ~/.config/fish/fixes.fish

if test -f ~/.local.fish
    source ~/.local.fish
end
