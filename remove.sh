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

brew remove dnsmasq
sudo rm -f /etc/resolver/app
sudo rm -f /etc/resolver/vm
sudo rm -f /usr/local/etc/dnsmasq.conf
brew services cleanup
rm -f $HOME/.clear-colours
brew remove git-flow

source $HOME/.dotfiles/scripts/dotfiles.sh

exec $SHELL -l
