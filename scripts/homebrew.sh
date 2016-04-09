#!/usr/bin/env bash

sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Add bash to the shells
BASHPATH=$(brew --prefix)/bin/bash
sudo echo $BASHPATH >> /etc/shells
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION

# Patch bashmarks
cd `brew --prefix bashmarks`/libexec/
curl https://patch-diff.githubusercontent.com/raw/huyng/bashmarks/pull/52.patch | patch bashmarks.sh
cd -

# Symlink ffmpeg for Dropshare
ln -s `which ffmpeg` /usr/local/bin/ffmpeg-static

# Install glances
pip install bottle pysnmp zeroconf netifaces influxdb statsd matplotlib pystache py-cpuinfo glances

# Install HTTPie plugins
pip install --upgrade pip
pip install httpie-oauth
pip install httpie-jwt-auth

