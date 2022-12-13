function git_cd
    cd (string escape (git rev-parse --show-toplevel))
    if count $argv > /dev/null
        $argv
    end
end
