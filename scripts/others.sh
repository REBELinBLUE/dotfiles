#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install HTTPie plugins
sudo chown -R $(whoami) /usr/local
pip install --upgrade pip
sudo chown -R $(whoami) /usr/local
pip install httpie-oauth
pip install httpie-jwt-auth

# Install additional CLIs
cp $HOME/.dotfiles/bin/notify-send /usr/local/bin/notify-send
ln -s `which ffmpeg` /usr/local/bin/ffmpeg-static

chmod +x /usr/local/bin/notify-send
chmod +x /usr/local/bin/ffmpeg-static

git clone https://github.com/shannonmoeller/up.git /opt/bash-up

git clone https://github.com/huyng/bashmarks.git /opt/bashmarks

# Patch bashmarks
curl https://patch-diff.githubusercontent.com/raw/huyng/bashmarks/pull/52.patch | patch -t -d /opt/bashmarks bashmarks.sh
