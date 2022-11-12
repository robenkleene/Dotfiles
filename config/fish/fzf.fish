if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end
# This sets up the fzf history which is better than Fish's builtin history
# If you comment these out, you'll have to define __fzfcmd like below
fzf_key_bindings

set -xg FZF_DEFAULT_OPTS "--height 40% --reverse"

function _robenkleene-fzf-z-widget
    set -l cmd "fasd -Rdl"

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
# Mosh sometimes prints this character for this binding
bind Ω _robenkleene-fzf-z-widget

