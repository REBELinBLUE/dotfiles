#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
	e_error "The update script is only for OS X"
	exit 1
fi

# Remove stuff

brew remove grip
brew remove octant
brew remove popeye
brew remove kubespy
brew remove git-cal
brew remove sshrc

#source $HOME/.dotfiles/scripts/dotfiles.sh
