#!/usr/bin/env bash

# Install vagrant
brew tap caskroom/cask
brew cask install vagrant

# Install vagrant plugins
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-notify
vagrant plugin install vagrant-reload

curl https://patch-diff.githubusercontent.com/raw/fgrehm/vagrant-notify/pull/22.patch | patch ~/.vagrant.d/gems/gems/vagrant-notify-0.4.0/lib/vagrant-notify/plugin.rb

# Install homestead
vagrant box add --provider virtualbox laravel/homestead
