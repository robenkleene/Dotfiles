# fasd
if command -sq fasd
    function __fasd_run -e fish_preexec -d "fasd takes record of the directories changed into"
        if test $argv[1] != "exit"
            command fasd --proc (command fasd --sanitize "$argv") >"/dev/null" 2>&1 &
        end
    end
    function fasd_cd -d "fasd builtin cd"
      if test (count $argv) -le 1
        command fasd "$argv"
      else
        fasd -e 'printf %s' $argv | read -l ret
        test -z "$ret"; and return
        test -d "$ret"; and cd "$ret"; or printf "%s\n" $ret
      end
    end
    # alias z="fasd_cd -d"
end

# Ruby
source ~/.config/fish/vendor/chruby/chruby.fish
source ~/.config/fish/vendor/chruby/auto.fish
# Not sure why this isn't working
# chruby ruby-2.5.3

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
