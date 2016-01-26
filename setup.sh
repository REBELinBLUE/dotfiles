#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

source ~/.dotfiles/files/.bashrc

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install composer
if [[ ! "$(type -P composer)" ]]; then
    echo "Installing composer"
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar $DOTFILES/bin/composer
    chmod +x $DOTFILES/bin/composer
fi

brew update

# Install `wget` with IRI support
brew install wget --with-iri

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install some other useful utilities like `sponge`
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils --with-default-names

# Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names

# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`
brew install bash

# Install extras
brew install binutils
brew install diffutils
brew install ed --default-names
brew install gnu-indent --with-default-names
brew install gnu-getopt --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install grep --with-default-names
brew install wdiff --with-gettext
brew install nano --disable-nls --enable-color --enable-extra --enable-multibuffer --enable-nanorc --enable-utf8
brew install file-formula
brew install vim --override-system-vi
brew install ack gzip watch git git-lfs git-extras tig less openssh rsync unzip
brew install dnsmasq node readline docker ccat top-osx screen gnutls gawk sqlite osquery 

# Install completions
brew install vagrant-completion bash-completion bash-git-prompt 

# Install media tools 
brew install mplayer media-info xvid ffmpeg rtmpdump atomicparsley id3v2

# Install get iplayer
brew tap dinkypumpkin/get_iplayer
brew update
brew install --with-deps get_iplayer

# Install vagrant plugins
vagrant plugin install vagrant-vbguest

# Install glances
brew install python
pip install bottle pysnmp zeroconf netifaces influxdb statsd matplotlib pystache py-cpuinfo glances

# Remove outdated versions from the cellar.
brew cleanup