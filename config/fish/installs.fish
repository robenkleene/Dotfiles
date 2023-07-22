# zoxide
function __z_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command ~/.bin/z_add (builtin pwd -L)
end

# This doesn't work because the `$fish_killring` is a read-only variable
# function __sync_clipboard --on-event fish_focus_in
#     set fish_killring (safepaste) $fish_killring 
# end

if test -n "$INSIDE_EMACS"
    set -Ux PAGER cat
    set -Ux GIT_PAGER cat
end

# This doesn't work for some reason
# switch (uname)
#     case Linux
#         set -Ux RUST_LLDB "lldb-6.0"
# end

# Python
# So slow!
# if test -d $HOME/.pyenv
#     set -Ux PYENV_ROOT $HOME/.pyenv
#     pyenv init - | source
# end

# llvm
# This doesn't seem to be working anyway
# switch (uname)
#     case Darwin
#         set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)
# end

# These cannot be set in the `fish_sync_variables` function due to special
# handling
# These contains checks do not work
if set -q HOMEBREW_DIR
    if not contains $HOMEBREW_DIR/share/man $MANPATH
        set -q MANPATH || set -gx MANPATH ''
        set -gx MANPATH $MANPATH $HOMEBREW_DIR/share/man
    end
    if not contains $HOMEBREW_DIR/share/info $INFOPATH
        set -q INFOPATH || set -gx INFOPATH ''
        set -gx INFOPATH $INFOPATH $HOMEBREW_DIR/share/info
    end
end

# fzf
if test -e $HOMEBREW_DIR/opt/fzf/shell/key-bindings.fish
    source $HOMEBREW_DIR/opt/fzf/shell/key-bindings.fish
    fzf_key_bindings
end
function _robenkleene-fzf-z-parentdir-widget
    ~/.bin/z_parentdir_fzf | read -l result

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
bind \e- _robenkleene-fzf-z-parentdir-widget
