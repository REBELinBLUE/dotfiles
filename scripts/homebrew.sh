#!/usr/bin/env bash

source ../files/.functions

if [ "$(uname)" != "Darwin" ]; then
    error "The setup script is only for OS X"
    exit 1;
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add bash to the shells - Rootless needs to be disabled
# http://osxdaily.com/2015/10/05/disable-rootless-system-integrity-protection-mac-os-x/
BASHPATH=$(brew --prefix)/bin/bash
chsh -s $BASHPATH # will set for current user only.

SIP_STATUS=$(csrutil status)
if [[ $SIP_STATUS == *"enabled"* ]]; then
    error 'SIP is enabled so /etc/shells can not be modified.'
    read -p "Press [Enter] to continue..."
else
    sudo echo $BASHPATH >> /etc/shells
fi

# Patch bashmarks
curl https://patch-diff.githubusercontent.com/raw/huyng/bashmarks/pull/52.patch | patch -t -d `brew --prefix bashmarks`/libexec/ bashmarks.sh
