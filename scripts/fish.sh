#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo git clone http://github.com/techwizrd/fishmarks.git /opt/fishmarks

# Install OMF
curl -SsL http://get.oh-my.fish | fish
