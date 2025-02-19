function rk_push
    ssh_start && begin; egit -p || egitn; end && ~/.bin/sgitt_auto
end
