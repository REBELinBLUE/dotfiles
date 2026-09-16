#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff

brew remove openssl@1.1
brew remove docker-completion

#source $HOME/.dotfiles/scripts/dotfiles.sh
