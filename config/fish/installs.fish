# fasd
if command -sq fasd
    function __fasd_run -e fish_preexec -d "fasd takes record of the directories changed into"
        if test $argv[1] != exit
            command fasd --proc (command fasd --sanitize "$argv") >/dev/null 2>&1 &
        end
    end
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
