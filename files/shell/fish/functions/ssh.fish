function ssh
    command cat $HOME/.ssh/config.d/*.config > $HOME/.ssh/config

    ##set -l SSHCOMMAND 'sshrc' # FIXME: SEE https://github.com/Russell91/sshrc/pull/76 because gtar is no longer using default-names
    set -l SSHCOMMAND 'command ssh'

    # TODO: Clean this up
    if [ $argv = "mycloud" ]
        set SSHCOMMAND 'command ssh'
    else if [ $argv = "mypassport" ]
        set SSHCOMMAND 'command ssh'
    else if [ $argv = "imac"  ]
        set SSHCOMMAND 'command ssh'
    else if [ $argv = "mbp" ]
        set SSHCOMMAND 'command ssh'
    end

    eval $SSHCOMMAND $argv
end
