function sc_cd_root
    if git rev-parse --is-inside-work-tree &> /dev/null
        cd (string escape (git rev-parse --show-toplevel))
    else
        cd (string escape (hg root))
    end
    if count $argv > /dev/null
        cd $argv
    end
end
