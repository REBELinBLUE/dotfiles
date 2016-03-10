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

# Install Source Code Pro fonts
cd /tmp
curl -L https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip > fonts.zip
unzip fonts.zip
rm -f fonts.zip
cp -f source-code-pro*/TTF/*.ttf ~/Library/Fonts
rm -rf source-code-pro*
