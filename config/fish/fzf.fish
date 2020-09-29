if test -f ~/.fzf/shell/key-bindings.fish
  source ~/.fzf/shell/key-bindings.fish
end
fzf_key_bindings

set -xg FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git --exclude .DS_Store'
set -xg FZF_ALL_COMMAND 'fd --hidden --exclude .git --exclude .DS_Store'

bind \ec fzf-cd-widget
