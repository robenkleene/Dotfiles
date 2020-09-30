if command -sq fasd
  function __fasd_run -e fish_preexec -d "fasd takes record of the directories changed into"
      if test $argv[1] != "exit"
          command fasd --proc (command fasd --sanitize "$argv") > "/dev/null" 2>&1 &
      end
  end
end

source ~/.config/fish/vendor/chruby/chruby.fish
source ~/.config/fish/vendor/chruby/auto.fish

