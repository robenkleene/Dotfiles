function v
    if test -z "$argv"
      eval $VIM_COMMAND .
    else
      eval $VIM_COMMAND $argv
    end
end
