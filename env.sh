#!/bin/sh

#launchctl setenv GNUPGHOME $HOME/.config/gnupg

cd ~/Library/LaunchAgents
ln -sfv ~/.dotfiles/prefs/environment.plist
launchctl load -w environment.plist
