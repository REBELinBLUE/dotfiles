#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


if [ -f ~/.bashrc ]; then
    rm -f ~/.bashrc
fi

ln -s ~/.dotfiles/files/.bashrc ~/.bashrc

if [ -f ~/.bash_profile ]; then
    rm  -f ~/.bash_profile
fi

ln -s ~/.dotfiles/files/.bash_profile ~/.bash_profile

if [ -f ~/.editorconfig ]; then
    rm -f ~/.editorconfig
fi

ln -s ~/.dotfiles/files/.editorconfig ~/.editorconfig

if [ -f ~/.inputrc ]; then
    rm -f ~/.inputrc
fi

ln -s ~/.dotfiles/files/.inputrc ~/.inputrc

if [ -f ~/.gitconfig ]; then
    rm -f ~/.gitconfig
fi

ln -s ~/.dotfiles/files/.gitconfig ~/.gitconfig

if [ -f ~/.gitignore ]; then
    rm -f ~/.gitignore
fi

ln -s ~/.dotfiles/files/.gitignore ~/.gitignore

if [ -f ~/.nanorc ]; then
    rm -f ~/.nanorc
fi

ln -s ~/.dotfiles/files/.nanorc ~/.nanorc

if [ -f ~/.tvnamer.json ]; then
    rm -f ~/.tvnamer.json
fi

ln -s ~/.dotfiles/files/.tvnamer.json ~/.tvnamer.json

if [ -f ~/.ssh/config ]; then
    rm -f ~/.ssh/config
fi

ln -s ~/.dotfiles/files/.ssh/config ~/.ssh/config


source ~/.bashrc
