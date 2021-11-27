function ssh
    command rm -f $HOME/.ssh/config

    set -l count 1
    for f in $HOME/.ssh/config.d/*.config
        if [ $count != 1 ]
            echo "" >> $HOME/.ssh/config
        end

        command cat $f >> $HOME/.ssh/config

        set -l count (math $count + 1)
    end
    set -e count

    command osascript -e 'display notification "Touch your YubiKey after submitting the User PIN" with title "ssh wants to authenticate!"'
    command ssh $argv
end
