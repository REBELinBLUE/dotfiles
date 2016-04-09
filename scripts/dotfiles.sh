#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ -f ~/.bash_profile ]; then
    rm ~/.bash_profile
fi

ln -s ~/.dotfiles/files/.bash_profile ~/.bash_profile

if [ -f ~/.bashrc ]; then
    rm ~/.bashrc
fi

ln -s ~/.dotfiles/files/.bashrc ~/.bashrc

source ~/.bashrc
