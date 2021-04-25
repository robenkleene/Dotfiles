# Hooray!
set fish_greeting

if test -f ~/.bin/print_shell_status
  ~/.bin/print_shell_status
end

if test -f ~/.config_local.fish
    source ~/.config_local.fish
end

source ~/.config/fish/settings.fish
source ~/.config/fish/variables.fish
source ~/.config/fish/installs.fish
source ~/.config/fish/fzf.fish
source ~/.config/fish/alias.fish
