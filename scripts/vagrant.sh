#!/usr/bin/env bash

source ~/.dotfiles/files/.functions

# Install vagrant plugins
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-notify
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-bindfs

# Install vagrant plugins for work machine
vagrant plugin install vagrant-proxyconf

# Patch vagrant notify
curl https://patch-diff.githubusercontent.com/raw/fgrehm/vagrant-notify/pull/22.patch | patch -t -d ~/.vagrant.d/gems/gems/vagrant-notify-0.4.0/lib/vagrant-notify/ plugin.rb

# Install homestead & debian
vagrant box add --provider virtualbox laravel/homestead
vagrant box add --provider virtualbox debian/jessie64
vagrant box add --provider virtualbox ubuntu/trusty64

if [ "$(uname)" == "Darwin" ]; then
    SetFile -a V ~/VirtualBox\ VMs/

    if [ ! -d ~/Vagrant/ ]; then
        mkdir ~/Vagrant/
    fi
fi
