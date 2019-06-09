#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Remove stuff
brew remove dnsmasq
sudo rm /usr/local/etc/dnsmasq.conf
sudo rm -rf /etc/resolver/

#source $HOME/.dotfiles/scripts/dotfiles.sh
