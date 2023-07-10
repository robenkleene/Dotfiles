function gur --wraps='ssh_start && git pull -r' --description 'alias gur=ssh_start && git pull -r'
  ssh_start && git pull -r $argv
        
end
