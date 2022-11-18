function ut --wraps='ssh_git_pull_all -t' --description 'alias ut=ssh_git_pull_all -t'
  ssh_git_pull_all -t $argv; 
end
