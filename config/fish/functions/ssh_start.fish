function ssh_start
    eval (ssh-agent -s)
    ssh-add
end
