#!/usr/bin/env bash

source ~/.dotfiles/files/.functions

if [ "$(uname)" != "Darwin" ]; then
    error "The setup script is only for OS X"
    exit 1;
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    info "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install brew apps
brew tap homebrew/bundle
brew bundle --file=brewfiles/all

# On work computer
#brew bundle --file=brewfiles/work

# On MacBook Air
# brew bundle --file=brewfiles/personal

# On iMac
# brew bundle --file=brewfiles/personal
# brew bundle --file=brewfiles/imac

source scripts/homebrew.sh
source scripts/others.sh
source scripts/vagrant.sh
source scripts/dotfiles.sh
source scripts/osx.sh

#git clone https://github.com/huyng/bashmarks.git /opt/bashmarks
#git clone https://github.com/magicmonty/bash-git-prompt.git /opt/bash-git-prompt
