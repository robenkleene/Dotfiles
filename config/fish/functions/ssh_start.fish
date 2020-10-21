function ssh_start
    switch (uname)
        case Linux
           if test -z $SSH_AGENT_PID 
               ssh_start
           end
    end
end
