#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

source ~/.dotfiles/files/.bashrc

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# todo
# symlink .editorconfig, .gitconfig, .nanorc and .ssh/config
