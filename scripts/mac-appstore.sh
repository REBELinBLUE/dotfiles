#!/usr/bin/env bash

source ~/.dotfiles/files/.functions

if [ "$(uname)" != "Darwin" ]; then
    error "The setup script is only for OS X"
    exit 1;
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# TODO: Prompt to login to the MAS

mas install 402434720 # Name Mangler
mas install 1054607607 # Helium
mas install 407963104 # Pixelmator
mas install 442160987 # Flycut
mas install 467939042 # Growl
mas install 443987910 # 1Password
mas install 975937182 # Fantastical 2
mas install 523620159 # CleanMyDrive 2
mas install 411643860 # DaisyDisk
mas install 557168941 # Tweetbot
mas install 588726889 # ReadKit
mas install 402383384 # Base
mas install 803453959 # Slack
mas install 416812579 # File Multi Tool 5
mas install 924726344 # Deliveries
mas install 870659406 # Stache
mas install 497799835 # Xcode 7.3
mas install 449589707 # Dash

# mas install 409201541 # Pages
# mas install 409183694 # Keynote
# mas install 409203825 # Numbers
# mas install 682658836 # GarageBand
# mas install 408981434 # iMovie
# mas install 465069360 # My Movies Pro
# mas install 451907568 # Paprika Recipe Manager
#mas install 425424353 # The Unarchiver
