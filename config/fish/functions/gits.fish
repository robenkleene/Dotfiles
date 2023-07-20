function gits --wraps='ssh_start && git' --description 'alias gits=ssh_start && git'
  ssh_start && git $argv
        
end
