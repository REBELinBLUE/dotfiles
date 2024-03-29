#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

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
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

# Install brew apps
brew tap homebrew/bundle
brew bundle --file=brewfiles/all
brew bundle --file=brewfiles/extras

# On work computer
# brew bundle --file=brewfiles/work

# On home computer
# brew bundle --file=brewfiles/personal

source $HOME/.dotfiles/scripts/homebrew.sh
source $HOME/.dotfiles/scripts/dotfiles.sh
source $HOME/.dotfiles/scripts/others.sh
source $HOME/.dotfiles/scripts/node.sh
#source $HOME/.dotfiles/scripts/osx.sh
source $HOME/.dotfiles/scripts/fish.sh
source $HOME/.dotfiles/scripts/phputils.sh

#scutil --set HostName iMac.local
