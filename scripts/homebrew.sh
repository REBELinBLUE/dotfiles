#!/usr/bin/env bash

sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


brew update

# Install `wget` with IRI support
brew install wget --with-iri

# Install curl
brew install curl --with-openssl
brew link --force curl

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

BASHPATH=$(brew --prefix)/bin/bash
sudo echo $BASHPATH >> /etc/shells
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION

# Install extras
brew install binutils
brew install homebrew/dupes/diffutils
brew install ed --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-getopt --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install homebrew/dupes/grep --with-default-names
brew install wdiff --with-gettext
brew install homebrew/dupes/nano --disable-nls --enable-color --enable-extra --enable-multibuffer --enable-nanorc --enable-utf8
brew install vim --override-system-vi
brew install ack gzip watch git git-lfs git-fresh git-extras git-flow tig less openssh rsync unzip pgcli mycli
brew install dnsmasq node readline ccat screen gnutls gawk sqlite osquery htop-osx diff-so-fancy
brew install terminal-notifier tree tvnamer

brew tap alexandregz/MXhomebrew
brew install bashmarks
cd `brew --prefix bashmarks`/libexec/
curl https://patch-diff.githubusercontent.com/raw/huyng/bashmarks/pull/52.patch | patch bashmarks.sh
cd -

brew tap homebrew/completions

# Install completions
brew install vagrant-completion bash-completion bash-git-prompt

# Install media tools
brew install mplayer media-info xvid ffmpeg rtmpdump atomicparsley id3v2

# Install get iplayer
brew tap dinkypumpkin/get_iplayer
brew update
brew install --with-deps get_iplayer

brew install httpie gist asciinema

# Install glances
brew install python
pip install bottle pysnmp zeroconf netifaces influxdb statsd matplotlib pystache py-cpuinfo glances

# Remove outdated versions from the cellar.
brew cleanup
