function gu --wraps='ssh_start && git pull' --description 'alias gu=ssh_start && git pull'
  ssh_start && git pull $argv
        
end
