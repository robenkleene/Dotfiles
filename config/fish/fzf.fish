if test -f ~/.fzf/shell/key-bindings.fish
    # This sets up the fzf history which is better than Fish's builtin history
    # If you comment these out, you'll have to define __fzfcmd like below
    source ~/.fzf/shell/key-bindings.fish
    fzf_key_bindings
else
    function __fzfcmd
        test -n "$FZF_TMUX"; or set FZF_TMUX 0
        test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
        if [ -n "$FZF_TMUX_OPTS" ]
            echo "fzf-tmux $FZF_TMUX_OPTS -- "
        else if [ $FZF_TMUX -eq 1 ]
            echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
        else
            echo "fzf"
        end
    end
end

set -xg FZF_DEFAULT_OPTS "--height 40% --reverse"

function _robenkleene-fzf-z-widget
    ~/.bin/z_fzf | read -l result

    if test -d "$result"
        set -l result_path (string escape "$result")
        set -l commandline (commandline)
        if test -z $commandline
            commandline "cd $result_path"
            commandline -f repaint
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \ez _robenkleene-fzf-z-widget

function _robenkleene-fzf-z-subdir-widget
    ~/.bin/z_fzf_subdir | read -l result

    if test -d "$result"
        set -l result_path (string escape "$result")
        set -l commandline (commandline)
        if test -z $commandline
            commandline "cd $result_path"
            commandline -f repaint
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \ec _robenkleene-fzf-z-subdir-widget

function _robenkleene-fzf-open-widget
    set -l cmd "~/.bin/find_ls"
    eval "$cmd | "(__fzfcmd) | read -l result

    if test -e "$result"
        set -l result_path (string escape "$result")
        set -l commandline (commandline)
        if test -z $commandline
            if test -d "$result"
                commandline "cd $result_path"
            else
                commandline "$EDITOR $result_path"
            end
            commandline -f repaint
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \eo _robenkleene-fzf-open-widget
