#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add bash to the shells
BASHPATH=$(brew --prefix)/bin/bash
sudo echo $BASHPATH >> /etc/shells
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION

# Patch bashmarks
curl https://patch-diff.githubusercontent.com/raw/huyng/bashmarks/pull/52.patch | patch `brew --prefix bashmarks`/libexec/bashmarks.sh

# Symlink ffmpeg for Dropshare
ln -s `which ffmpeg` /usr/local/bin/ffmpeg-static
