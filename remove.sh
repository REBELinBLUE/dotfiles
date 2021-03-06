#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Remove stuff

brew remove terraform terraformer

if [ -e $HOME/.local/share/vagrant ]; then
    rm -rf $HOME/.local/share/vagrant/
fi

#source $HOME/.dotfiles/scripts/dotfiles.sh
