#!/usr/bin/env bash

# Originally from https://gist.github.com/scottsb/479bebe8b4b86bf17e2d
#
# Uses `diskutil image` (hdiutil is deprecated as of macOS 27). The one
# exception is `compact`, which has no diskutil equivalent yet.

set -euo pipefail

# ---------------------------------------------------------
# Customizable Settings
# ---------------------------------------------------------

# where to store the sparse bundle
VOLUME_PATH="${CASE_SAFE_VOLUME_PATH:-${HOME}/.workspace.dmg.sparsebundle}"

# location where workspace will be mounted
MOUNT_POINT="${CASE_SAFE_MOUNT_POINT:-${HOME}/Workspace}"

# name of workspace as visible in Finder
VOLUME_NAME="${CASE_SAFE_VOLUME_NAME:-Workspace}"

# volume size
VOLUME_SIZE="${CASE_SAFE_VOLUME_SIZE:-60g}"

# ---------------------------------------------------------
# Functionality
# ---------------------------------------------------------

LABEL="com.${VOLUME_NAME}"
PLIST="${HOME}/Library/LaunchAgents/${LABEL}.plist"
LOG="${HOME}/Library/Logs/${LABEL}.log"

create() {
    # `diskutil image create blank -fs` cannot create case-sensitive APFS
    # (it silently falls back to case-insensitive), so create an
    # unformatted image and format it ourselves.
    diskutil image create blank --format UDSB --size "${VOLUME_SIZE}" -fs None "${VOLUME_PATH}"

    local disk
    disk=$(diskutil image attach --noMount "${VOLUME_PATH}" | awk 'NR==1 {print $1}')
    diskutil eraseDisk "Case-sensitive APFS" "${VOLUME_NAME}" GPT "${disk}"
    diskutil eject "${disk}"
}

automount() {
    attach
    mkdir -p "$(dirname "${PLIST}")"
    cat <<EOF > "${PLIST}"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>RunAtLoad</key>
        <true/>
        <key>Label</key>
        <string>${LABEL}</string>
        <key>ProgramArguments</key>
        <array>
            <string>/usr/sbin/diskutil</string>
            <string>image</string>
            <string>attach</string>
            <string>--nobrowse</string>
            <string>--mountPoint</string>
            <string>${MOUNT_POINT}</string>
            <string>${VOLUME_PATH}</string>
        </array>
        <key>ProcessType</key>
        <string>Background</string>
        <key>StandardOutPath</key>
        <string>${LOG}</string>
        <key>StandardErrorPath</key>
        <string>${LOG}</string>
        <key>ThrottleInterval</key>
        <integer>60</integer>
    </dict>
</plist>
EOF
    launchctl bootstrap "gui/$(id -u)" "${PLIST}"
}

noautomount() {
    detach
    launchctl bootout "gui/$(id -u)" "${PLIST}" || true
    rm -f "${PLIST}"
}

# Prints the whole-disk identifier backing the image mounted at MOUNT_POINT,
# or nothing if it isn't mounted.
image_disk() {
    [ -d "${MOUNT_POINT}" ] || return 0

    # `diskutil info <path>` resolves to whichever volume contains the path,
    # so make sure it's actually our volume and not the parent (boot) volume.
    local resolved mounted_at store
    resolved=$(cd "${MOUNT_POINT}" && pwd -P)
    mounted_at=$(diskutil info -plist "${MOUNT_POINT}" | plutil -extract MountPoint raw - 2>/dev/null) || return 0
    [ "${mounted_at}" = "${resolved}" ] || return 0

    # The mounted volume lives in a synthesized APFS container; eject the
    # image's physical disk so the image itself is detached.
    store=$(diskutil info -plist "${MOUNT_POINT}" | plutil -extract APFSPhysicalStores.0.APFSPhysicalStore raw -)
    diskutil info -plist "${store}" | plutil -extract ParentWholeDisk raw -
}

detach() {
    local disk
    disk=$(image_disk)
    if [ -n "${disk}" ]; then
        diskutil eject "${disk}"
    fi
}

attach() {
    if [ -n "$(image_disk)" ]; then
        echo "Workspace already mounted at ${MOUNT_POINT}"
        return 0
    fi
    diskutil image attach --nobrowse --mountPoint "${MOUNT_POINT}" "${VOLUME_PATH}"
}

resize() {
    detach
    hdiutil compact "${VOLUME_PATH}" -batteryallowed
    diskutil image resize --size "${VOLUME_SIZE}" "${VOLUME_PATH}"
    attach
}

compact() {
    detach
    # No `diskutil image` equivalent exists for compact yet.
    hdiutil compact "${VOLUME_PATH}" -batteryallowed
    attach
}

help() {
    cat <<EOF
usage: workspace <command>

Possible commands:
    create       Initialize case-sensitive volume (only needed first time)
    automount    Configure macOS to mount the volume automatically on restart
    noautomount  Stop macOS from mounting the volume automatically on restart
    mount        Attach the case-sensitive volume
    unmount      Detach the case-sensitive volume
    resize       Resize the case-sensitive volume
    compact      Remove any unneeded reserved space in the volume
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
    printf "workspace: '%s' is not a valid command.\n\n" "$1" >&2
    help >&2
    exit 1
}

case "${1:-}" in
    create) create;;
    automount) automount;;
    noautomount) noautomount;;
    mount) attach;;
    unmount) detach;;
    resize) resize;;
    compact) compact;;
    config) config;;
    help|'') help;;
    *) invalid "$1";;
esac
