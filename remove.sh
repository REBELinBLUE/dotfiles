#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff
rm -rf /usr/local/bin/pstorm
rm -rf /usr/local/bin/datagrip


#source $HOME/.dotfiles/scripts/dotfiles.sh
