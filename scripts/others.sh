#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Hide VirtualBox folder
if [ ! -d $HOME/VirtualBox\ VMs/ ]; then
    mkdir $HOME/VirtualBox\ VMs/
fi

SetFile -a V $HOME/VirtualBox\ VMs/

# Install HTTPie plugins
sudo chown -R $(whoami) /usr/local
pip install --upgrade pip
sudo chown -R $(whoami) /usr/local
pip install httpie-oauth
pip install httpie-jwt-auth

# Install additional CLIs
cp $HOME/.dotfiles/bin/notify-send /usr/local/bin/notify-send
ln -s `which ffmpeg` /usr/local/bin/ffmpeg-static


# For some reason 0.6.1 which is in homebrew causes problems with vagrant
curl https://raw.githubusercontent.com/Russell91/sshrc/0.6/sshrc --silent -o /usr/local/bin/vagrant-sshrc

chmod +x /usr/local/bin/notify-send
chmod +x /usr/local/bin/ffmpeg-static
chmod +x /usr/local/bin/vagrant-sshrc
