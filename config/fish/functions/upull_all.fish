function upull_all --wraps='ssh_start && ssh_git_pull_all' --description 'alias ua=ssh_start && ssh_git_pull_all'
  ssh_start && ssh_git_pull_all $argv
        
end
