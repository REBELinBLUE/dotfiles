#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add bash, fish and zsh to the shells - Rootless needs to be disabled
# http://osxdaily.com/2015/10/05/disable-rootless-system-integrity-protection-mac-os-x/
# will set for current user only.
SIP_STATUS=$(csrutil status)
if [[ $SIP_STATUS == *"enabled"* ]]; then
    e_error 'SIP is enabled so /etc/shells can not be modified.'
    read -p "Press [Enter] to continue..."
else
    BASHPATH=$(brew --prefix)/bin/bash
    FISHPATH=$(brew --prefix)/bin/fish
    ZSHPATH=$(brew --prefix)/bin/zsh

    sudo echo $BASHPATH >> /etc/shells
    sudo echo $FISHPATH >> /etc/shells
    sudo echo $ZSHPATH >> /etc/shells

    chsh -s $FISHPATH
fi

sudo SetFile -a V /opt

brew install https://raw.githubusercontent.com/shtirlic/yubikeylockd/master/yubikeylockd.rb
