function sleepnas -d "Sleep the NAS"
    command cat $HOME/.ssh/config.d/*.config > $HOME/.ssh/config
    command ssh nas "sudo halt &"
end
