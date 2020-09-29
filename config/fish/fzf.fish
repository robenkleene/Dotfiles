if test -f ~/.fzf/shell/key-bindings.fish
  source ~/.fzf/shell/key-bindings.fish
end
fzf_key_bindings

set -xg FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git --exclude .DS_Store'
set -xg FZF_ALL_COMMAND 'fd --hidden --exclude .git --exclude .DS_Store'

function robenkleene-fzf-cd-widget
  set -l commandline (__fzf_parse_commandline)
  if test "$PWD/" != "$HOME/**/*"
    echo "Only use in a subdirectory of home" >&2
    commandline -f repaint
    return 1
  end
  fzf-cd-widget
end
bind \ec robenkleene-fzf-cd-widget
