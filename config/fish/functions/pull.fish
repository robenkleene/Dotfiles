function pull --wraps='ssh_start && ~/.bin/egit_update' --description 'alias u=ssh_start && ~/.bin/egit_update'
    ssh_start && ~/.bin/egit_update $argv && fish_update
end
