# zoxide
if command -sq zoxide
    zoxide init fish | source
end

# Implement `!!`
function bangbang --on-event fish_postexec
    alias !!="$argv[1]"
end

# Python
if test -d $HOME/.pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    pyenv init - | source
end

# llvm
switch (uname)
    case Darwin
        set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)
end
