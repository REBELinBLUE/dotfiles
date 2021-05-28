#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

mas install 419330170  # Moom (3.2.22)
mas install 425424353  # The Unarchiver (4.3.3)
mas install 1462114288 # Grammarly for Safari (9.17)
mas install 1289583905 # Pixelmator Pro (2.0.8)
mas install 429449079  # Patterns (1.2)
mas install 288545208  # Instapaper (8.0.1)
mas install 1481302432 # Instapaper Save (1.2)
mas install 1462114288 # Grammarly for Safari (9.30)
mas install 1006087419 # SnippetsLab (1.9.3)
mas install 975937182  # Fantastical (3.3.10)
mas install 402383384  # Base (2.5.2)
mas install 1176895641 # Spark (2.9.22)
mas install 1191449274 # ToothFairy (2.7.3)
mas install 290986013  # Deliveries (9.1.2)
mas install 1480068668 # Messenger (97.11.116)
mas install 485812721  # TweetDeck (3.18)
mas install 1147396723 # WhatsApp (2.2114.10)
mas install 897814548  # Proxie (3.1.0)

mas install 497799835  # Xcode (12.5)

# mas install 507659816  # Network Radar (2.10)
# mas install 1515445551 # Pi-hole Remote (2.10.1)
# mas install 1330266650 # HomePass (1.9.6)
# mas install 1292995895 # HomeCam (2.1.4)

#mas install 1511185140 # MoneyWiz (2021.19.1)
#mas install 1153157709 # Speedtest (1.20)
#mas install 1351683336 # My Movies 2 Pro - Movie & TV (2.11)
#mas install 1303222628 # Paprika Recipe Manager 3 (3.6.4)

#mas install 409183694 # Keynote (11.0.1)
#mas install 409201541 # Pages (11.0)
#mas install 409203825 # Numbers (11.0)
#mas install 408981434 # iMovie (10.2.3)
