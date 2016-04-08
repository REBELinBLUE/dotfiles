#!/usr/bin/env bash

# Install composer
if [[ ! "$(type -P composer)" ]]; then
    echo "Installing composer"
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar $DOTFILES/bin/composer
    chmod +x $DOTFILES/bin/composer
fi

# Hide VirtualBox folder
mkdir -q ~/VirtualBox\ VMs/
SetFile -a V ~/VirtualBox\ VMs/

