#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff

brew remove speedtest-cli php@8.1 pidof libass icu4c@77 libgit2@1.7
brew untap homebrew/bundle homebrew/services homebrew/command-not-found
 
#source $HOME/.dotfiles/scripts/dotfiles.sh
