if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end
fzf_key_bindings

set -xg FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git --exclude .DS_Store'
set -xg FZF_ALL_COMMAND 'fd --hidden --exclude .git --exclude .DS_Store'
set -xg FZF_TMUX_HEIGHT '40%'
set -xg FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"

set -xg FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -xg FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'

function _robenkleene-fzf-cd-widget
    if not string match --regex --quiet "^$HOME\/.+" $PWD
        echo "Only use in a subdirectory of home" >&2
        commandline -f repaint
        return 1
    end

    set -l cmd $FZF_ALT_C_COMMAND
    set -l commandline (commandline)
    begin
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
    end

    commandline -f repaint
end
bind \ec _robenkleene-fzf-cd-widget

function _robenkleene-fzf-z-widget
    set -l cmd "fasd -Rdl"
    set -l commandline (commandline)
    begin
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

    set -l cmd $FZF_CTRL_T_COMMAND
    set -l commandline (commandline)
    begin
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
    end

    commandline -f repaint
end
bind \ee _robenkleene-fzf-edit-widget

function _robenkleene_fish_commands
    string split ' ' (zsh -c "echo \${(k)commands}")
    string split ' ' (functions -n)
    builtin --names
end

function _robenkleene-fzf-commands-widget
    set -l cmd "_robenkleene_fish_commands"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            commandline -i "$result"
        end
    end

    commandline -f repaint
end
bind \ex _robenkleene-fzf-commands-widget

function _robenkleene-fzf-developer-widget
    set -l cmd "fd --type d --exclude .git . ~/Developer"
    set -l commandline (commandline)
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -e "$result"
            set -l result_path (string escape "$result")
            if test -z $commandline
                commandline "cd $result_path"
                commandline -f execute
            else
                commandline -i "$result_path"
            end
        end
    end

    commandline -f repaint
end
bind \eg _robenkleene-fzf-developer-widget
