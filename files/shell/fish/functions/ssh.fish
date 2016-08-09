function ssh
    command cat $HOME/.ssh/config.d/*.config > $HOME/.ssh/config

    set -l SSHCOMMAND 'sshrc'

    # TODO: Clean this up
    if [ $argv = "mycloud" ]
        set SSHCOMMAND 'ssh'
    else if [ $argv = "mypassword" ]
        set SSHCOMMAND 'ssh'
    else if [ $argv = "imac"  ]
        set SSHCOMMAND 'ssh'
    else if [ $argv = "mba" ]
        set SSHCOMMAND 'ssh'
    end

    eval $SSHCOMMAND $argv
end
