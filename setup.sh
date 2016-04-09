#!/usr/bin/env bash

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

print_error() {
    printf " [✖] %s\n" "$1"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"

    return $1
}

print_success() {
    printf " [✔] %s\n" "$1"
}

source scripts/homebrew.sh
source scripts/others.sh
source scripts/vagrant.sh
source scripts/osx.sh
source scripts/dotfiles.sh
