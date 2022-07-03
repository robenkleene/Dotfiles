if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end
# This sets up the fzf history which is better than Fish's builtin history
# If you comment these out, you'll have to define __fzfcmd like below
fzf_key_bindings
# function __fzfcmd
#   test -n "$FZF_TMUX"; or set FZF_TMUX 0
#   test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
#   if [ -n "$FZF_TMUX_OPTS" ]
#     echo "fzf-tmux $FZF_TMUX_OPTS -- "
#   else if [ $FZF_TMUX -eq 1 ]
#     echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
#   else
#     echo "fzf"
#   end
# end

# Note this returns files and symlinks, regardless of whether they're
# directories, when really we probably want files or symlinks to files
set -xg FZF_DEFAULT_COMMAND 'fd --strip-cwd-prefix --type f --follow --type l --hidden --exclude .git --exclude .hg --exclude .DS_Store'
set -xg FZF_ALL_COMMAND 'fd --strip-cwd-prefix --hidden --follow --exclude .git --exclude .hg --exclude .DS_Store'
set -xg FZF_TMUX_HEIGHT '40%'
set -xg FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"

set -xg FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# We don't return symlinks here because you can't cd to symlinks to files
set -xg FZF_ALT_C_COMMAND 'fd --strip-cwd-prefix --type d --hidden --follow --exclude .git --exclude .hg'

function _robenkleene-fzf-cd-widget
    set -l cmd $FZF_ALT_C_COMMAND
    if not string match --regex --quiet "^$HOME\/.+" $PWD
        set cmd "$cmd --max-depth 1"
    end

    set -l commandline (commandline)
    eval "$cmd | "(__fzfcmd) | read -l result

    if test -d "$result"
        set -l result_path (string escape "$result")
        if test -z $commandline
            commandline "cd $result_path"
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \ec _robenkleene-fzf-cd-widget
# Visual Studio Code prints this character for this binding
bind ç _robenkleene-fzf-cd-widget

function _robenkleene-fzf-z-widget
    set -l cmd "fasd -Rdl"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -d "$result"
        set -l result_path (string escape "$result")
        if test -z $commandline
            commandline "cd $result_path"
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \ez _robenkleene-fzf-z-widget
# Mosh sometimes prints this character for this binding
bind Ω _robenkleene-fzf-z-widget

function _robenkleene-fzf-edit-widget
    set -l cmd $FZF_CTRL_T_COMMAND
    if not string match --regex --quiet "^$HOME\/.+" $PWD
        set cmd "$cmd --max-depth 1"
    end

    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        set -l result_path (string escape "$result")
        if test -z $commandline
            commandline "$EDITOR $result_path"
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \eo _robenkleene-fzf-edit-widget
bind \ee _robenkleene-fzf-edit-widget
# Visual Studio Code prints this character for this binding
bind ø _robenkleene-fzf-edit-widget

function _robenkleene_fish_commands
    string split ' ' (zsh -c "echo \${(k)commands}")
    string split ' ' (functions -n)
    builtin --names
end

function _robenkleene-fzf-commands-widget
    set -l cmd _robenkleene_fish_commands

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -n "$result"
        commandline -i "$result "
    end

    commandline -f repaint
end
bind \ex _robenkleene-fzf-commands-widget
# Visual Studio Code prints this character for this binding
bind ≈ _robenkleene-fzf-commands-widget

function _robenkleene-fzf-developer-widget
    # set -l cmd "fd --type d . ~/Developer"
    set -l cmd "find ~/Developer -type d -exec test -e '{}/.git' ';' -print -prune"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -d "$result"
        set -l result_path (string escape "$result")
        if test -z $commandline
            commandline "cd $result_path"
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \eg _robenkleene-fzf-developer-widget
# Visual Studio Code prints this character for this binding
bind © _robenkleene-fzf-developer-widget

function _robenkleene-fzf-quick-widget
    set -l cmd "fd --type d --follow . ~/Text ~/Documentation"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -d "$result"
        set -l result_path (string escape "$result")
        if test -z $commandline
            commandline "cd $result_path"
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
# bind \eo _robenkleene-fzf-quick-widget
# Visual Studio Code prints this character for this binding
# bind ø _robenkleene-fzf-quick-widget

function _robenkleene-fzf-quick-files-widget
    set -l cmd "fd --type f --follow . ~/Text ~/Documentation"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        set -l result_path (string escape "$result")
        if test -z $commandline
            commandline "$EDITOR $result_path"
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
# bind \eO _robenkleene-fzf-quick-files-widget
# bind \co _robenkleene-fzf-quick-files-widget

function _robenkleene-fzf-clipboard-widget
    set -l cmd "tac $HOME/.clipboard_history"
    set -l commandline (commandline)

    if test -z $commandline
        eval "$cmd |"(__fzfcmd) | ~/.bin/safecopy -s
    else
        commandline -i (eval "$cmd |"(__fzfcmd) | tr '\0' '\n')
    end

    commandline -f repaint
end
bind \e\\ _robenkleene-fzf-clipboard-widget
bind \ea\\ _robenkleene-fzf-clipboard-widget
