#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Remove stuff

# Stuff to remove on work mac when lockdown is over

brew remove vagrant-completion osquery aria2 neofetch cheat ssh-copy-id doitlive pick the_silver_searcher tree hh pv

brew untap caskroom/homebrew-fonts
brew untap caskroom/homebrew-versions
brew untap caskroom/homebrew-cask

rm /usr/local/bin/phpdoccheck /usr/local/bin/phpmd /usr/local/bin/phpcs /usr/local/bin/php-cs-fixer /usr/local/bin/notify-send
rm /private/etc/sudoers.d/vagrant /usr/local/bin/vagrant-sshrc m-cli

rm -rf ~/.local/share/vagrant/ ~/.cache/vagrant/ ~/.config/neofetch

#source $HOME/.dotfiles/scripts/dotfiles.sh
