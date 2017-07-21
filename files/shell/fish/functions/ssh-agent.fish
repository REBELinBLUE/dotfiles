function ssh-agent -d "start a new ssh agent"
    eval (command ssh-agent -c)
    ssh-add ~/.ssh/id_rsa
end
