function u --wraps='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update' --description 'alias u=ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
  ssh_start && ~/.bin/egit_update && fish_update $argv; 
end
