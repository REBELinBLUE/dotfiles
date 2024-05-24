#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff

kubectl krew remove access-matrix
kubectl krew remove get-all
kubectl krew remove resource-capacity
kubectl krew remove outdated
kubectl krew remove cert-manager

brew remove aws-sam-cli

#source $HOME/.dotfiles/scripts/dotfiles.sh
