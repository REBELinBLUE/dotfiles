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
                <string>/bin/sh</string>
                <string>-c</string>
                <string>${HOME}/.dotfiles/scripts/gpgagent.sh start</string>
            </array>
            <key>RunAtLoad</key>
            <true/>
        </dict>
    </plist>
EOF
    mkdir -p "${HOME}/Library/LaunchAgents"
    cp "gpg.gpg-agent.plist" "${HOME}/Library/LaunchAgents/gpg.gpg-agent.plist"
    rm -f "gpg.gpg-agent.plist"

    launchctl load "${HOME}/Library/LaunchAgents/gpg.gpg-agent.plist"

    #sudo launchctl enable gui/502/gpg.gpg-agent
    #sudo launchctl kickstart gui/502/gpg.gpg-agent
}

uninstall() {
    launchctl unload "${HOME}/Library/LaunchAgents/gpg.gpg-agent.plist"
    rm -f "${HOME}/Library/LaunchAgents/gpg.gpg-agent.plist"
}

start() {
    ln -sf $(gpgconf --list-dirs agent-ssh-socket) $SSH_AUTH_SOCK
    #/usr/local/MacGPG2/bin/gpgconf --launch gpg-agent
    /usr/local/MacGPG2/bin/gpg-connect-agent /bye > /dev/null
}

invalid() {
    printf "gpgagent: '$1' is not a valid command.\n\n";
    help
}

help() {
    cat <<EOF
usage: ./gpgagent.sh <command>

Possible commands:
    start       Start the GPG agent
    install     Configure macOS to automatically start GPG agent on restart
    help        Display this message
EOF
}

case "$1" in
    install) install;;
    uninstall) uninstall;;
    start) start;;
    help) help;;
    '') help;;
    *) invalid $1;;
esac
