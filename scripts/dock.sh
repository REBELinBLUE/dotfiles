#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

brew install dockutil

dockutil --remove all --no-restart
dockutil --add /Applications/Safari.app --no-restart
dockutil --add /Applications/Spark.app --no-restart
#dockutil --add /Applications/Instapaper.app --no-restart
#dockutil --add /Applications/Transmission.app --no-restart
dockutil --add /System/Applications/Music.app --no-restart
dockutil --add /System/Applications/Podcasts.app --no-restart
#dockutil --add /Applications/Plex.app --no-restart
dockutil --add /System/Applications/Reminders.app --no-restart
#dockutil --add /System/Applications/Notes.app --no-restart
dockutil --add /Applications/PhpStorm.app --no-restart
#dockutil --add /Applications/DataGrip.app --no-restart
#dockutil --add /Applications/Fork.app --no-restart
#dockutil --add /Applications/Paw.app --no-restart
#dockutil --add /Applications/Patterns.app --no-restart
dockutil --add /Applications/Visual\ Studio\ Code.app --no-restart
dockutil --add /Applications/iTerm.app --no-restart
dockutil --add /Applications/MoneyWiz.app

brew uninstall dockutil
