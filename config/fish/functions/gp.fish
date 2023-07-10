function gp --wraps='ssh_start && git push' --description 'alias gp=ssh_start && git push'
  ssh_start && git push $argv
        
end
