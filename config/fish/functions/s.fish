function s
    ssh_start && begin; egit -p || egitn; end && ~/.bin/sgitt_auto
end
