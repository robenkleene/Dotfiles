if test -f ~/.fzf/shell/key-bindings.fish
  source ~/.fzf/shell/key-bindings.fish
end
fzf_key_bindings

set -xg FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git --exclude .DS_Store'
set -xg FZF_ALL_COMMAND 'fd --hidden --exclude .git --exclude .DS_Store'
set -xg FZF_TMUX_HEIGHT '40%'
set -xg FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"

function _robenkleene-fzf-cd-widget
  if not string match --regex --quiet "^$HOME\/.+" $PWD
    echo "Only use in a subdirectory of home" >&2
    commandline -f repaint
    return 1
  end
end
bind \ec _robenkleene-fzf-cd-widget

function _robenkleene-fzf-z-widget
  set -l cmd "fasd -Rdl"
  set -l commandline (commandline)
  begin
    eval "$cmd | "(__fzfcmd) | read -l result
    if [ -n "$result" ]
      if test -z $commandline
        cd $result
      else
        commandline -i "$result"
      end
    end
  end
  commandline -f repaint
end
bind \ez _robenkleene-fzf-z-widget

function _robenkleene-fzf-edit-widget
  if not string match --regex --quiet "^$HOME\/.+" $PWD
    echo "Only use in a subdirectory of home" >&2
    commandline -f repaint
    return 1
  end
  set -l current_cmd (commandline)
  set -l commandline (__fzf_parse_commandline)
  set -l dir $commandline[1]
  set -l fzf_query $commandline[2]

  set -l cmd $FZF_CTRL_T_COMMAND

  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"
    eval "$cmd | "(__fzfcmd)' +m --query "'$fzf_query'"' | read -l result

    if test -z $current_cmd
      if [ -n "$result" ]
        eval $EDITOR \"$result\"
      end
    else
      commandline -i "$result"
    end
  end
  commandline -f repaint
end
bind \ee _robenkleene-fzf-edit-widget

# function _robenkleene-fzf-commands-widget
#   set -l commandline (__fzf_parse_commandline)
#   set -l dir $commandline[1]
#   set -l fzf_query $commandline[2]

#   set -l cmd string split ' ' '(zsh -c \"echo \${(k)commands}\"); string split ' ' (functions -n); builtin --names'

#   test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
#   begin
#     set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"
#     eval "$cmd | "(__fzfcmd)' +m --query "'$fzf_query'"' | read -l result

#     if [ -n "$result" ]
#       eval $EDITOR \"$result\"
#       commandline -t ""
#     end
#   end
#   commandline -f repaint
# end
# bind \ee _robenkleene-fzf-edit-widget



# builtin --names
# functions -n
# zsh -c "echo \${(k)commands}"
# string split ' ' (zsh -c "echo \${(k)commands}")

# string split ' ' (zsh -c "echo \${(k)commands}") && string split ' ' (functions -n) && builtin --names

# string split ' ' (zsh -c "echo \${(k)commands}"); string split ' ' (functions -n); builtin --names
