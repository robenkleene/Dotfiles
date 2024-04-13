# This doesn't work because the `$fish_killring` is a read-only variable
# function __sync_clipboard --on-event fish_focus_in
#     set fish_killring (safepaste) $fish_killring 
# end

if test -n "$INSIDE_EMACS"
    set -gx PAGER cat
    set -gx GIT_PAGER cat
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
