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

    command ssh $argv
end
