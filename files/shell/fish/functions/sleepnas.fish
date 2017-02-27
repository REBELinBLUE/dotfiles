function sleepnas -d "Sleep the NAS"
    command cat $HOME/.ssh/config.d/*.config > $HOME/.ssh/config
    #command ssh mycloud "/usr/sbin/shutdown.sh -h -P now"
end
