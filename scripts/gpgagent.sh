#!/usr/bin/env bash

install() {
    cat << EOF > /tmp/gpg.gpg-agent.plist
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
                <string>$HOME/.dotfiles/scripts/gpgagent.sh start</string>
            </array>
            <key>RunAtLoad</key>
            <true/>
        </dict>
    </plist>
EOF
    sudo cp "/tmp/gpg.gpg-agent.plist" "$HOME/Library/LaunchAgents/gpg.gpg-agent.plist"
    rm "/tmp/gpg.gpg-agent.plist"

    sudo launchctl load -w $HOME/Library/LaunchAgents/gpg.gpg-agent.plist
}

start() {
    /usr/local/MacGPG2/bin/gpgconf --launch gpg-agent
    ln -sf $HOME/.gnupg/S.gpg-agent.ssh $SSH_AUTH_SOCK
}

invalid() {
    printf "casesafe: '$1' is not a valid command.\n\n";
    help
}

case "$1" in
    install) install;;
    start) start;;
    *) invalid $1;;
esac
