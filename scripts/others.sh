#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install composer
if [[ ! "$(type -P composer)" ]]; then
    echo "Installing composer"
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer
fi

# Hide VirtualBox folder
if [ ! -d ~/VirtualBox\ VMs/ ]; then
    mkdir ~/VirtualBox\ VMs/
fi

SetFile -a V ~/VirtualBox\ VMs/

# Install glances
sudo chown -R $(whoami) /usr/local
pip install bottle pysnmp zeroconf netifaces influxdb statsd matplotlib pystache py-cpuinfo glances

# Install HTTPie plugins
pip install --upgrade pip
pip install httpie-oauth
pip install httpie-jwt-auth

# Install additional CLIs
cp ./bin/chdiff /usr/local/bin/chdiff
cp ./bin/notify-send /usr/local/bin/notify-send
cp ./bin/stree /usr/local/bin/stree
cp ./bin/subl /usr/local/bin/subl
cp ./bin/macdown /usr/local/bin/macdown

chmod +x /usr/local/bin/chdiff
chmod +x /usr/local/bin/notify-send
chmod +x /usr/local/bin/stree
chmod +x /usr/local/bin/subl
chmod +x /usr/local/bin/macdown
