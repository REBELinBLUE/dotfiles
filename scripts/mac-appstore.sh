#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

mas install 897814548  # Proxie (3.1.0)
mas install 419330170  # Moom (3.2.17)
mas install 425424353  # The Unarchiver (4.2.2)
mas install 1462114288 # Grammarly for Safari (9.17)
mas install 407963104  # Pixelmator (3.9)
mas install 467939042  # Growl (2.1.3)
mas install 429449079  # Patterns (1.2)
mas install 1481302432 # Instapaper (1.1)
mas install 1006087419 # SnippetsLab (1.9.2)
mas install 975937182  # Fantastical (3.1.4)
mas install 402383384  # Base (2.5.1)
mas install 1176895641 # Spark (2.8.2)
mas install 1191449274 # ToothFairy (2.6.2)
mas install 924726344  # Deliveries (3.2.3)

mas install 497799835  # Xcode (11.6)

#mas install 1153157709 # Speedtest (1.15)
#mas install 1351683336 # My Movies 2 Pro - Movie & TV (2.10)
#mas install 1303222628 # Paprika Recipe Manager 3 (3.4.5)

#mas install 409183694 # Keynote (10.1)
#mas install 409201541 # Pages (10.1)
#mas install 409203825 # Numbers (10.1)
#mas install 408981434 # iMovie (10.1.14)
