function u --wraps='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update' --wraps='ssh_start && ~/.bin/egit_update' --description 'alias u=ssh_start && ~/.bin/egit_update'
  ssh_start && ~/.bin/egit_update $argv
        
end
