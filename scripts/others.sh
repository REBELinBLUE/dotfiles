#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install HTTPie plugins
pip3 install --user --upgrade pip
pip3 install --user httpie-oauth
pip3 install --user httpie-jwt-auth
pip3 install --user http-prompt

curl -fsSL https://raw.githubusercontent.com/rgcr/m-cli/master/install.sh |  sh

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

cp -f "$HOME/.dotfiles/prefs/Monaco for Powerline.otf" $HOME/Library/Fonts/

git clone https://github.com/serialhex/nano-highlight.git /opt/nano-highlight

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install krew
)

kubectl krew install get-all
kubectl krew install access-matrix
kubectl krew install resource-capacity
kubectl krew install images
kubectl krew install rbac-lookup
kubectl krew install kubesec-scan
kubectl krew install who-can
kubectl krew install outdated
kubectl krew install tree
kubectl krew install pod-dive
kubectl krew install neat
kubectl krew install cert-manager

#kubectl krew install tap

helm plugin install https://github.com/databus23/helm-diff.git --version master
helm plugin install https://github.com/chartmuseum/helm-push.git
