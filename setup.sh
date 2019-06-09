#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
if ! type_exists 'brew'; then
    e_info "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install brew apps
brew tap homebrew/bundle
brew bundle --file=brewfiles/all
brew bundle --file=brewfiles/extras

# On work computer
#brew bundle --file=brewfiles/work

# On MacBook Air
# brew bundle --file=brewfiles/personal

# On iMac
# brew bundle --file=brewfiles/personal
# brew bundle --file=brewfiles/imac

source $HOME/.dotfiles/scripts/homebrew.sh
source $HOME/.dotfiles/scripts/others.sh
source $HOME/.dotfiles/scripts/phputils.sh
source $HOME/.dotfiles/scripts/node.sh
source $HOME/.dotfiles/scripts/vagrant.sh
source $HOME/.dotfiles/scripts/dotfiles.sh
source $HOME/.dotfiles/scripts/osx.sh
source $HOME/.dotfiles/scripts/bash.sh
source $HOME/.dotfiles/scripts/fish.sh

#scutil --set HostName iMac.local
