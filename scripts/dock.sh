#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

dockutil --remove all --no-restart
dockutil --add /Applications/Google\ Chrome.app --no-restart
dockutil --add /Applications/Spark.app --no-restart
dockutil --add /Applications/Franz.app --no-restart
dockutil --add /Applications/PhpStorm.app --no-restart
dockutil --add /Applications/DataGrip.app --no-restart
dockutil --add /Applications/Sublime\ Text.app --no-restart
dockutil --add /Applications/iTerm.app --no-restart