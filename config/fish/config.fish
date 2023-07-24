# Too dangerous to run on startup in case `tmux` or `emacs` is hanging
# if test -z $TMUX
#     ~/.bin/print_shell_status
# end

source ~/.config/fish/settings.fish
source ~/.config/fish/installs.fish
# Regenerate with `zoxide init fish > ~/.config/fish/zoxide.fish`
source ~/.config/fish/zoxide.fish

source ~/.config/fish/abbr.fish

if test -f ~/.local.fish
    source ~/.local.fish
end
