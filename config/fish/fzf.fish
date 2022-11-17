# This sets up the fzf history which is better than Fish's builtin history
# If you comment these out, you'll have to define __fzfcmd like below
if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end
fzf_key_bindings

set -xg FZF_DEFAULT_OPTS "--height 40% --reverse"

function _robenkleene-fzf-z-widget
    set -l cmd "zoxide query --list"

    eval "$cmd | "(__fzfcmd) | read -l result
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

function _robenkleene-fzf-cd-widget
    set -l cmd "fd --strip-cwd-prefix --type d --hidden --follow --max-depth 1 --exclude .git --exclude .hg"
    if not string match --regex --quiet "^$HOME\/.+" $PWD
        set cmd "$cmd --max-depth 1"
    end

    eval "$cmd | "(__fzfcmd) | read -l result

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
bind \ec _robenkleene-fzf-cd-widget

function _robenkleene-fzf-edit-widget
    set -l cmd "fd --strip-cwd-prefix --type f --follow --type l --hidden --max-depth 1 --exclude .DS_Store"
    if not string match --regex --quiet "^$HOME\/.+" $PWD
        set cmd "$cmd --max-depth 1"
    end


    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        set -l result_path (string escape "$result")
        set -l commandline (commandline)
        if test -z $commandline
            commandline "$EDITOR $result_path"
            commandline -f repaint
            commandline -f execute
        else
            commandline -i "$result_path"
        end
    end

    commandline -f repaint
end
bind \eo _robenkleene-fzf-edit-widget
