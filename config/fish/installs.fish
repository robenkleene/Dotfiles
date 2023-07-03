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
