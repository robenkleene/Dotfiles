function hg_cd
    cd (string escape (hg root))
    if count $argv > /dev/null
        exec $argv
    end
end
