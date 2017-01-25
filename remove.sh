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
# STUFF HERE

php-switch 56
brew remove php56-xdebug
brew install php56-xdebug

php-switch 70
brew remove php70-xdebug
brew install php70-xdebug

php-switch 71
brew remove php71-xdebug
brew install php71-xdebug

php-switch 70

source $HOME/.dotfiles/scripts/dotfiles.sh
