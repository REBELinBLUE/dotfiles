#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff
brew remove php@8.0
rm -rf /opt/homebrew/etc/php/php@8.0 /opt/homebrew/lib/php/pecl/20200930


#source $HOME/.dotfiles/scripts/dotfiles.sh
