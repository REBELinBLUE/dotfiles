#!/usr/bin/env bash

# From https://gist.github.com/scottsb/479bebe8b4b86bf17e2d

# ---------------------------------------------------------
# Customizable Settings
# ---------------------------------------------------------

# where to store the sparse-image
VOLUME_PATH="${CASE_SAFE_VOLUME_PATH:-${HOME}/.workspace.dmg.sparseimage}"

# location where workspace will be mounted
MOUNT_POINT="${CASE_SAFE_MOUNT_POINT:-${HOME}/Workspace}"

# name of workspace as visible in Finder
VOLUME_NAME="${CASE_SAFE_VOLUME_NAME:-Workspace}"

# volume size
VOLUME_SIZE="${CASE_SAFE_VOLUME_SIZE:-60g}"

# ---------------------------------------------------------
# Functionality
# ---------------------------------------------------------

create() {
    hdiutil create -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size ${VOLUME_SIZE} -volname ${VOLUME_NAME} ${VOLUME_PATH}
}

automount() {
    attach
    cat << EOF > "/tmp/com.${VOLUME_NAME}.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>RunAtLoad</key>
        <true/>
        <key>Label</key>
        <string>com.${VOLUME_NAME}</string>
        <key>ProgramArguments</key>
        <array>
            <string>hdiutil</string>
            <string>attach</string>
            <string>-notremovable</string>
            <string>-nobrowse</string>
            <string>-mountpoint</string>
            <string>${MOUNT_POINT}</string>
            <string>${VOLUME_PATH}</string>
        </array>
    </dict>
</plist>
EOF
    sudo cp "/tmp/com.${VOLUME_NAME}.plist" "/Library/LaunchDaemons/com.${VOLUME_NAME}.plist"
    rm "/tmp/com.${VOLUME_NAME}.plist"
}

noautomount() {
    detach
    sudo rm -f "/Library/LaunchDaemons/com.${VOLUME_NAME}.plist"
}

detach() {
    m=$(hdiutil info | grep "${MOUNT_POINT}" | cut -f1)
    if [ ! -z "$m" ]; then
        sudo hdiutil detach $m
    fi
}

attach() {
    sudo hdiutil attach -notremovable -nobrowse -mountpoint ${MOUNT_POINT} ${VOLUME_PATH}
}

resize() {
    compact
    detach
    hdiutil resize -size ${VOLUME_SIZE} ${VOLUME_PATH}
    attach
}

compact() {
    detach
    hdiutil compact ${VOLUME_PATH} -batteryallowed
    attach
}

help() {
    cat <<EOF
usage: casesafe <command>
Possible commands:
    create       Initialize case-sensitive volume (only needed first time)
    automount    Configure macOS to mount the volume automatically on restart
    noautomount  Stop macOS from mounting the volume automatically on restart
    mount        Attach the case-sensitive volume
    unmount      Detach the case-sensitive volume
    resize       Resize the case-sensitive volume
    compact      Remove any uneeded reserved space in the volume
    config       Show current configuration and instructions on changing
    help         Display this message
EOF
}

config() {
    cat <<EOF
The behavior of the script may be modified by setting the following environment variables.
If not set the script will use sane defaults.
CASE_SAFE_MOUNT_POINT
    Location where case-sensitive volume will be mounted
    Current effective value: ${MOUNT_POINT}
CASE_SAFE_VOLUME_PATH
    Location where image file should be stored
    Current effective value: ${VOLUME_PATH}
CASE_SAFE_VOLUME_NAME
    Name of case-sensitive workspace as visible in macOS Finder app
    Current effective value: ${VOLUME_NAME}
CASE_SAFE_VOLUME_SIZE
    Maximum size of volume (will auto-grow up to this)
    Current effective value: ${VOLUME_SIZE}
EOF
}

invalid() {
    printf "casesafe: '$1' is not a valid command.\n\n";
    help
}

case "$1" in
    create) create;;
    automount) automount;;
    noautomount) noautomount;;
    mount) attach;;
    unmount) detach;;
    resize) resize;;
    compact) compact;;
    config) config;;
    help) help;;
    '') help;;
    *) invalid $1;;
esac
