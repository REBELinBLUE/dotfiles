#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff



rm -rf "${HOME}/Library/Application Support/Sublime Text/Packages/User/VcsGutter.sublime-settings"
open "${HOME}/Library/Application Support/Sublime Text/Installed Packages"

#source $HOME/.dotfiles/scripts/dotfiles.sh
