function ssh
    command cat $HOME/.ssh/config.d/*.config > $HOME/.ssh/config

    set -l SSHCOMMAND 'sshrc'

    # TODO: Clean this up
    if [ $argv = "mycloud" ]
        set SSHCOMMAND 'command ssh'
    else if [ $argv = "mypassport" ]
        set SSHCOMMAND 'command ssh'
    else if [ $argv = "imac"  ]
        set SSHCOMMAND 'command ssh'
    else if [ $argv = "mba" ]
        set SSHCOMMAND 'command ssh'
    end

    eval $SSHCOMMAND $argv
end
