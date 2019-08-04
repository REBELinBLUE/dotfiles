#!/usr/bin/env bash

# From https://gist.github.com/scottsb/479bebe8b4b86bf17e2d

# ---------------------------------------------------------
# Customizable Settings
# ---------------------------------------------------------

# where to store the sparse-image
WORKSPACE=${HOME}/.workspace.dmg.sparseimage

# location where workspace will be mounted
MOUNTPOINT=${HOME}/Workspace

# name of workspace as visible in Finder
VOLUME_NAME=Workspace

# volume size
VOLUME_SIZE=60g

# ---------------------------------------------------------
# Functionality
# ---------------------------------------------------------

create() {
    hdiutil create -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size ${VOLUME_SIZE} -volname ${VOLUME_NAME} ${WORKSPACE}
}

automount() {
    mkdir -p  ~/Library/LaunchDaemons/
    cat << EOF > ~/Library/LaunchDaemons/com.workspace.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>RunAtLoad</key>
        <true/>
        <key>Label</key>
        <string>com.workspace</string>
        <key>ProgramArguments</key>
        <array>
            <string>hdiutil</string>
            <string>attach</string>
            <string>-notremovable</string>
            <string>-nobrowse</string>
            <string>-mountpoint</string>
            <string>${MOUNTPOINT}</string>
            <string>${WORKSPACE}</string>
        </array>
    </dict>
</plist>
EOF
}

detach() {
    m=$(hdiutil info | grep "${MOUNTPOINT}" | cut -f1)
    if [ ! -z "$m" ]; then
        sudo hdiutil detach $m
    fi
}

attach() {
    sudo hdiutil attach -notremovable -nobrowse -mountpoint ${MOUNTPOINT} ${WORKSPACE}
}

compact() {
    detach
    hdiutil compact ${WORKSPACE} -batteryallowed
    attach
}

help() {
    printf "Possible commands:\n\n";
    printf "\033[0;33m%-20s\033[0m%s\n" "create" "Initialize case-sensitive volume (only needed first time)";
    printf "\033[0;33m%-20s\033[0m%s\n" "automount" "Configure OS X to mount the volume automatically on restart";
    printf "\033[0;33m%-20s\033[0m%s\n" "mount" "Attach the case-sensitive volume";
    printf "\033[0;33m%-20s\033[0m%s\n" "unmount" "Detach the case-sensitive volume";
    printf "\033[0;33m%-20s\033[0m%s\n" "compact" "Remove any unneeded reserved space in the volume";
    printf "\033[0;33m%-20s\033[0m%s\n" "help" "Display this message";
}

invalid() {
    printf "\033[31m✖ '$1' is not a valid command.\033[0m \n\n";
    help
}

case "$1" in
    create) create;;
    automount) automount;;
    mount) attach;;
    unmount) detach;;
    compact) compact;;
    help) help;;
    '') help;;
    *) invalid $1;;
esac
