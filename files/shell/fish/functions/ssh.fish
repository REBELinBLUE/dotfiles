function ssh
    command cat $HOME/.ssh/config.d/*.config > $HOME/.ssh/config

    set -l SSHCOMMAND 'command ssh'

    eval $SSHCOMMAND $argv
end
