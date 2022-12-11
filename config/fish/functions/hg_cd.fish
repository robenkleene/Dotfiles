function hg_cd
    cd (string escape (hg root))
    if count $argv > /dev/null
        cd $argv
    end
end
