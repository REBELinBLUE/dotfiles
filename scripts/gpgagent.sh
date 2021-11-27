#!/usr/bin/env bash

install() {
    cat << EOF > gpg.gpg-agent.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>gpg.gpg-agent</string>
        <key>ProgramArguments</key>
        <array>
            <string>/usr/local/MacGPG2/bin/gpg-connect-agent</string>
            <string>/bye</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
EOF

    cat << EOF > gpg.gpg-agent-symlink.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>gpg.gpg-agent-symlink</string>
        <key>ProgramArguments</key>
        <array>
            <string>/bin/sh</string>
            <string>-c</string>
            <string>/bin/ln -sf ${HOME}/.gnupg/S.gpg-agent.ssh \$SSH_AUTH_SOCK</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
EOF
    mkdir -p "${HOME}/Library/LaunchAgents"
    cp -f "gpg.gpg-agent.plist" "${HOME}/Library/LaunchAgents/"
    cp -f "gpg.gpg-agent-symlink.plist" "${HOME}/Library/LaunchAgents/"
    rm -f "gpg.gpg-agent.plist"
    rm -f "gpg.gpg-agent-symlink.plist"

    USERID=$(id -u)
    launchctl bootstrap gui/$USERID "${HOME}/Library/LaunchAgents/gpg.gpg-agent.plist"
    launchctl bootstrap gui/$USERID "${HOME}/Library/LaunchAgents/gpg.gpg-agent-symlink.plist"
}

uninstall() {
    USERID=$(id -u)
    launchctl bootout gui/$USERID "${HOME}/Library/LaunchAgents/gpg.gpg-agent.plist"
    launchctl bootout gui/$USERID "${HOME}/Library/LaunchAgents/gpg.gpg-agent-symlink.plist"

    rm -f "${HOME}/Library/LaunchAgents/gpg.gpg-agent.plist"
    rm -f "${HOME}/Library/LaunchAgents/gpg.gpg-agent-symlink.plist"
}

invalid() {
    printf "gpgagent: '$1' is not a valid command.\n\n";
    help
}

help() {
    cat <<EOF
    "$@"
usage: ./gpgagent.sh <command>

Possible commands:
    install     Configure macOS to automatically start GPG agent on restart
    uninstall   Remove the configuration
    help        Display this message
EOF
}

case "$1" in
    install) install;;
    uninstall) uninstall;;
    help) help;;
    '') help;;
    *) invalid $1;;
esac
