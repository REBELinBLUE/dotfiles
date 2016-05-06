#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

e_error "Nothing to remove"
exit 1

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

brew cask zap dockertoolbox

echo "Removing Applications..."
sudo rm -rf /Applications/Docker

echo "Removing docker binaries..."
sudo rm -f /usr/local/bin/docker
sudo rm -f /usr/local/bin/docker-machine
sudo rm -r /usr/local/bin/docker-machine-driver*
sudo rm -f /usr/local/bin/docker-compose

echo "Removing boot2docker.iso"
sudo rm -rf /usr/local/share/boot2docker

source $HOME/.dotfiles/scripts/dotfiles.sh

exec $SHELL -l
