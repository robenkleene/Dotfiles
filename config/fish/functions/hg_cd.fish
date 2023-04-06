function hg_cd
    cd (string escape (hg root))
    if count $argv > /dev/null
        # We can probably automatically `cd` now that `hg_root` can be used to
        # execute a command from root?
        # $argv
        cd $argv
    end
end
