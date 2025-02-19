function rk_pull_settings --wraps='ssh_start && ~/.bin/egit_update -s' --description 'alias us=ssh_start && ~/.bin/egit_update -s'
  ssh_start && ~/.bin/egit_update -s $argv
        
end
