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

brew update
brew upgrade

composer global install

# Update brew apps
brew bundle --file=brewfiles/all

# On work computer
#brew bundle --file=brewfiles/work

# On home computer
# brew bundle --file=brewfiles/personal

source $HOME/.dotfiles/scripts/dotfiles.sh

brew-php-switcher $(cat ~/.cache/php_version) -s
