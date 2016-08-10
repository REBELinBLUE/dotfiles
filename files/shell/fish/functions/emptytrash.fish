function emptytrash -d "Empty the trash and Quarantine on OS X"
    sudo command rm -rfv "/Volumes/*/.Trashes"
    sudo command rm -rfv ~/.Trash
    sudo command rm -rfv "/private/var/log/asl/*.asl"
    command sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
end
