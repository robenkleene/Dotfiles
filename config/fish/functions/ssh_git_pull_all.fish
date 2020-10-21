function ssh_git_pull_all
    switch (uname)
        case Linux
           if test -z $SSH_AGENT_PID 
               ssh_start
           end
    end
    git_pull_all
end
