if test -f ~/.fzf/shell/key-bindings.fish
  source ~/.fzf/shell/key-bindings.fish
end
fzf_key_bindings

set -xg FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git --exclude .DS_Store'
set -xg FZF_ALL_COMMAND 'fd --hidden --exclude .git --exclude .DS_Store'

function robenkleene-fzf-cd-widget
  set -l commandline (__fzf_parse_commandline)
  if not string match --regex --quiet "^$HOME\/.+" $PWD
    echo "Only use in a subdirectory of home" >&2
    commandline -f repaint
    return 1
  end
  fzf-cd-widget
end
bind \ec robenkleene-fzf-cd-widget

function robenkleene-fzf-z-widget
  set -l commandline (__fzf_parse_commandline)
  set -l dir $commandline[1]
  set -l fzf_query $commandline[2]

  set -l cmd "fasd -Rdl"

  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"
    eval "$cmd | "(__fzfcmd)' +m --query "'$fzf_query'"' | read -l result

    if [ -n "$result" ]
      cd $result
      commandline -t ""
    end
  end
  commandline -f repaint
end
bind \ez robenkleene-fzf-z-widget

function robenkleene-fzf-edit-widget
  set -l commandline (__fzf_parse_commandline)
  if not string match --regex --quiet "^$HOME\/.+" $PWD
    echo "Only use in a subdirectory of home" >&2
    commandline -f repaint
    return 1
  end
  set -l dir $commandline[1]
  set -l fzf_query $commandline[2]

  set -l cmd $FZF_CTRL_T_COMMAND

  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"
    eval "$cmd | "(__fzfcmd)' +m --query "'$fzf_query'"' | read -l result

    if [ -n "$result" ]
      eval $EDITOR \"$result\"
      commandline -t ""
    end
  end
  commandline -f repaint
end
bind \ee robenkleene-fzf-edit-widget
