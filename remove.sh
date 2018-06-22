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
rm $(brew --prefix php@5.6)/pecl/20131226/xdebug.so
rm -rf usr/local/Cellar/php@5.6/
brew remove php@5.6
brew remove glances

#source $HOME/.dotfiles/scripts/dotfiles.sh
