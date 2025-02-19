# Don't inheret these variables from parent process (otherwise the parents
# variables will have global scope which will override the universal scope)
set --erase --global EDITOR
set --erase --global VISUAL
set --erase --global PAGER
set --erase --global LESS

source ~/.config/fish/settings.fish
source ~/.config/fish/installs.fish
# Regenerate with `zoxide init fish > ~/.config/fish/zoxide.fish`
source ~/.config/fish/zoxide.fish
source ~/.config/fish/abbr.fish
source ~/.config/fish/alias.fish

if test -f ~/.local.fish
    source ~/.local.fish
end
