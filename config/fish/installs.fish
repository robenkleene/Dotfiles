# zoxide
if command -sq zoxide
    zoxide init fish | source
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
