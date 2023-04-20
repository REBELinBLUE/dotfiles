#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff
brew remove kubernetes-cli kubectx
kubectl krew install ctx
kubectl krew install ns

#source $HOME/.dotfiles/scripts/dotfiles.sh
