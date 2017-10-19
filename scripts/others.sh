#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install HTTPie plugins
#sudo chown -R $(whoami) /usr/local
pip3 install --upgrade pip
#sudo chown -R $(whoami) /usr/local
pip3 install httpie-oauth
pip3 install httpie-jwt-auth
pip3 install http-prompt
pip3 install --user 'cozmo[camera]'

# Install additional CLIs
ln -s `which ffmpeg` /usr/local/bin/ffmpeg-static

# Install nerd fonts - https://github.com/ryanoasis/nerd-fonts
# cd ~/Library/Fonts
# curl -fLo "Sauce Code Pro Black Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Black/complete/Sauce%20Code%20Pro%20Black%20Nerd%20Font%20Complete.ttf
# curl -fLo "Sauce Code Pro Bold Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf
# curl -fLo "Sauce Code Pro Extra-Light Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Extra-Light/complete/Sauce%20Code%20Pro%20ExtraLight%20Nerd%20Font%20Complete.ttf
# curl -fLo "Sauce Code Pro Light Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Light/complete/Sauce%20Code%20Pro%20Light%20Nerd%20Font%20Complete.ttf
# curl -fLo "Sauce Code Pro Medium Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Medium/complete/Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete.ttf
# curl -fLo "Sauce Code Pro Regular Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
# curl -fLo "Sauce Code Pro Semibold Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete.ttf
# cd -

cp -f "$HOME/.dotfiles/files/Monaco for Powerline.otf" $HOME/Library/Fonts/

git clone  https://github.com/serialhex/nano-highlight.git /opt/nano-highlight

gem install travis -v 1.8.8 --no-rdoc --no-ri
