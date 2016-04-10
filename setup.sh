#!/usr/bin/env bash

if [ "$(uname)" != "Darwin" ]; then
    echo -e "\e[41;1m The setup script is only for OS X \e[0m"
    exit 1;
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install brew apps
brew tap homebrew/bundle
brew bundle

source scripts/homebrew.sh
source scripts/others.sh
source scripts/vagrant.sh
source scripts/dotfiles.sh
source scripts/osx.sh
