#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff
brew remove helm
brew install helmenv
kbenv install 1.25.2
helmenv install 3.11.3

kbenv use 1.25.2
helmenv use 3.11.3

rm -rf  $XDG_CONFIG_HOME/docker

#source $HOME/.dotfiles/scripts/dotfiles.sh
