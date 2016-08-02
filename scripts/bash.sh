#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

git clone https://github.com/shannonmoeller/up.git /opt/bash-up

git clone https://github.com/huyng/bashmarks.git /opt/bashmarks

# Patch bashmarks
curl https://patch-diff.githubusercontent.com/raw/huyng/bashmarks/pull/52.patch | patch -t -d /opt/bashmarks bashmarks.sh

if ! is_os "darwin"; then
    git clone https://github.com/magicmonty/bash-git-prompt.git /opt/bash-git-prompt
fi
