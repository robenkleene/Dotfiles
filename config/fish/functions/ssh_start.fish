function ssh_start
    switch (uname)
        case Linux
           if test -z $SSH_AGENT_PID
                eval (ssh-agent -c)
                ssh-add
           end
    end
end
