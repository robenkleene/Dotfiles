# zoxide
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (builtin pwd -L)
end

if test -n "$INSIDE_EMACS"
    set -Ux PAGER cat
    set -Ux GIT_PAGER cat
end

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
