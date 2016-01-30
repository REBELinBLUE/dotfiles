#!/usr/bin/env bash

# Install vagrant
brew tap caskroom/cask
brew cask install vagrant

# Install vagrant plugins
vagrant plugin install vagrant-vbguest

# Install homestead
vagrant box add --provider virtualbox laravel/homestead 