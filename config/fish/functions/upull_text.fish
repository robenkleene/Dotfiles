function upull_text --wraps='ssh_start && ssh_git_pull_all -t' --description 'alias ut=ssh_start && ssh_git_pull_all -t'
  ssh_start && ssh_git_pull_all -t $argv
        
end
