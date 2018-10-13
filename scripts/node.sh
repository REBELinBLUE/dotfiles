#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# brew remove node
# sudo rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
# sudo rm -rf /uca/local/lib/node_modules
# brew install node

npm install -g eslint create-project jscs npm-check json5 nanoleaves @vue/cli serve
npm config -g set init-license MIT
