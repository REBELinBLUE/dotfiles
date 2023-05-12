#!/usr/bin/env bash

install() {
    cat << EOF > com.1password.SSH_AUTH_SOCK.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.1password.SSH_AUTH_SOCK</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/sh</string>
    <string>-c</string>
    <string>/bin/ln -sf ${HOME}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock \$SSH_AUTH_SOCK</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF

EOF
    mkdir -p "${HOME}/Library/LaunchAgents"
    cp -f "com.1password.SSH_AUTH_SOCK.plist" "${HOME}/Library/LaunchAgents/"
    rm -f "com.1password.SSH_AUTH_SOCK.plist"

    launchctl load -w "${HOME}/Library/LaunchAgents/com.1password.SSH_AUTH_SOCK.plist"
}

uninstall() {
    launchctl unload -w "${HOME}/Library/LaunchAgents/com.1password.SSH_AUTH_SOCK.plist"

    rm -f "${HOME}/Library/LaunchAgents/com.1password.SSH_AUTH_SOCK.plist"
}

invalid() {
    printf "1passwordagent: '$1' is not a valid command.\n\n";
    help
}

help() {
    cat <<EOF
usage: ./1passwordagent.sh <command>

Possible commands:
    install     Configure macOS to automatically start 1password agent on restart
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
